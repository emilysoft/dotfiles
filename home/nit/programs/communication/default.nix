{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  imports = [
    ./zen-browser.nix
    ./vesktop.nix
    ./newsboat.nix
  ];

  config = lib.mkIf enabled {
    programs.librewolf.enable = true;
    home.packages = with pkgs; [
      ferdium
      telegram-desktop
    ];
  };
}
