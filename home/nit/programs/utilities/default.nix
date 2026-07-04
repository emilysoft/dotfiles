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
      bleachbit
      contrast
      wordbook
      dialect
      pika-backup
      qbittorrent
      nicotine-plus
      p7zip
      warehouse
      pawncc
      gnome-logs
      gnome-solanum
      pandoc
      texliveFull
      wtype
      cloc
    ];
  };
}
