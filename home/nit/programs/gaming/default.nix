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
    ./retroarch.nix
  ];

  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      heroic
      steam
      ruffle
    ];

    programs.lutris.enable = true;
  };
}
