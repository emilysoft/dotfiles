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
      space-cadet-pinball
    ];

    programs.lutris.enable = true;
  };
}
