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
      anki-bin
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
      qutebrowser
      protonup-qt
      recorder
      pawncc
      video-trimmer
      appflowy
      flameshot
      gnome-logs
      gnome-clocks
      gnome-font-viewer
      gnome-decoder
      gnome-solanum
      proton-vpn
      pandoc
      texliveFull
      gedit
      smile
      trilium-desktop
    ];
  };
}
