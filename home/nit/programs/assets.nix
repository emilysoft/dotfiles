{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "dotfiles-assets";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "neetoons";
    repo = "dotfiles";
    rev = "assets";
    sha256 = "sha256-otwBiOS4scfq++Qwno5ww/Q7ObdE+XurYJIUmsQd0xk=";
  };

  installPhase = ''
    mkdir -p $out/share/assets/
    cp -r * $out/share/assets/
  '';
}
