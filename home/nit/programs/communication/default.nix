{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  imports = [
    ./vesktop.nix
    ./newsboat.nix
  ];

  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      ferdium
      telegram-desktop
    ];
  };
}
