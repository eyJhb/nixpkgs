{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  version = "1.6.0";
  name = "arduino-mk-${version}";

  src = fetchgit {
    url = "https://github.com/sudar/Arduino-Makefile.git";
    rev = "refs/tags/${version}";
    sha256 = "0k646nm2n3kji4hp727467z0bicfa67w43ll06mxsdqssnbwgghi";
  };

  phases = ["installPhase"];
  installPhase = "cp -r $src $out";

  meta = {
    description = "Makefile for Arduino sketches";
    homepage = https://github.com/sudar/Arduino-Makefile;
    license = stdenv.lib.licenses.lgpl21;
    maintainers = [ lib.maintainers.eyjhb ];
    platforms = stdenv.lib.platforms.unix;
  };
}

