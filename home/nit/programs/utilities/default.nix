{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      waypaper
      bleachbit
      contrast
      wordbook
      dialect
      pika-backup
      qbittorrent
      nicotine-plus
      p7zip
      peazip
      zstd
      warehouse
      protonup-qt
      recorder
      pawncc
      gnome-logs
      gnome-clocks
      gnome-font-viewer
      gnome-solanum
      gnome-calendar
      proton-vpn
      pandoc
      texliveFull
      smile
      wtype
      cloc
    ];
  };
}
