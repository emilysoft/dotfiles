{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  imports = [
    ./spicetify.nix
    ./mpv.nix
  ];
  config = lib.mkIf enabled {
    programs.obs-studio.enable = true;
    services.easyeffects.enable = true;

    home.packages = with pkgs; [
      kdePackages.elisa
      mixxx
      lmms
      gimp
      audacity
      pinta
      gcolor3
      kdePackages.kdenlive
      losslesscut-bin
      handbrake
      amberol
      pipeline
      openscreen
      reaper
    ];
  };
}
