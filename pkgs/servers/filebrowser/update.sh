#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl common-updater-scripts nodePackages.node2nix gnused nix coreutils jq

set -euo pipefail

OWNER=filebrowser
REPO=filebrowser

latestVersion="$(curl -s "https://api.github.com/repos/$OWNER/$REPO/releases?per_page=1" | jq -r ".[0].tag_name" | sed 's/^v//')"
currentVersion=$(nix-instantiate --eval -E "with import ./. {}; $REPO.version or (lib.getVersion $REPO)" | tr -d '"')

if [[ "$currentVersion" == "$latestVersion" ]]; then
  echo "$OWNER/$REPO is up-to-date: $currentVersion"
  exit 0
fi

update-source-version $REPO 0 0000000000000000000000000000000000000000000000000000000000000000
update-source-version $REPO "$latestVersion"

# use patched source
store_src="$(nix-build . -A $REPO.src --no-out-link)"

cd "$(dirname "${BASH_SOURCE[0]}")"

node2nix \
  --nodejs-14 \
  --development \
  --node-env ./node-env.nix \
  --output ./node-deps.nix \
  --input "$store_src/package.json" \
  --composition ./node-composition.nix

