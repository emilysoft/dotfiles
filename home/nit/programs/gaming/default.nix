{ pkgs, ... }:
{
  imports = [
    ./mangohud.nix
  ];

  programs.lutris.enable = true;

  home.packages = with pkgs; [
    heroic
    steam
  ];
}
