{
  # lib
# , nixosTests
 stdenv
, fetchFromGitHub
# , makeWrapper
# , nodejs
# , pkgs
}:

stdenv.mkDerivation rec {
  pname = "filebrowser";
  version = "2.21.1";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-acqLZ/AWW4P4EPJMBhAiM/B5LMloM7Hf0s2b0rc8wxQ=";
  };

  passthru.updateScript = ./update.sh;
}
