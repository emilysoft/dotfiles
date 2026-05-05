{pkgs, ...}: {
  fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.iosevka
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    dejavu_fonts
    corefonts
  ];
}
