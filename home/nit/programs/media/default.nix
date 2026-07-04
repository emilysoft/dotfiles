{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.media.enable;
in {
  imports = [
    ./spicetify.nix
    ./mpv.nix
  ];
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      mixxx
      lmms
      gimp
      audacity
      pinta
      gcolor3
      kdePackages.kdenlive
      video-trimmer
      handbrake
      pipeline
      openscreen
      reaper
    ];
  };
}
