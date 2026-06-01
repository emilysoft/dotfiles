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
      obsidian
      sticky-notes
      onlyoffice-desktopeditors
      anki-bin
      gedit
      readest
    ];
  };
}
