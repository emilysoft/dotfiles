{pkgs, ...}:
pkgs.multiStdenv.mkDerivation rec {
  pname = "pawncc";
  version = "3.10.11";
  src = pkgs.fetchFromGitHub {
    owner = "openmultiplayer";
    repo = "compiler";
    rev = "v${version}";
    hash = "sha256-voHp+e7aMh6tPJtKZIazgbvPrpJbgPVXraf3t/BP8DE=";
  };

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_C_FLAGS=-m32 -Wno-error=format-security -Wno-error=format"
    "-DCMAKE_SOURCE_DIR=source/compiler"
    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    "-DCMAKE_C_STANDARD=99"
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    python314
  ];

  configurePhase = ''
    cd source/compiler
    cmake ${pkgs.lib.concatStringsSep " " cmakeFlags}
  '';

  installPhase = "make";

  fixupPhase = ''
    mkdir -p $out/bin $out/lib $out/include
    cp pawncc pawndisasm pawnruns $out/bin
    cp libpawnc.so $out/lib/libpawnc.so
    cp -r ../../include $out/include
  '';

  doCheck = false;
}
