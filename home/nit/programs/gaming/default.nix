{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  imports = [
    ./mangohud.nix
  ];

  #programs.lutris.enable = true;
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      heroic
      steam
    ];
  };
}
