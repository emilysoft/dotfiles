{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "dotfiles-assets";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "emilysoft";
    repo = "assets";
    rev = "main";
    sha256 = "sha256-ubcfQgJbMIuZG2j38LvZc4lMMx3p2umgdGsJfaAhCkc=";
  };

  installPhase = ''
    mkdir -p $out/share/assets/
    cp -r * $out/share/assets/
  '';
}
