{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.iosevka
    dejavu_fonts
  ];
}
