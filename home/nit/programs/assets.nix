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
    sha256 = "sha256-VHk5tom8qRpCSMLSrsJYbUT7GJFryDlV1qkpPiaFxQA=";
  };

  installPhase = ''
    mkdir -p $out/share/assets/
    cp -r * $out/share/assets/
  '';
}
