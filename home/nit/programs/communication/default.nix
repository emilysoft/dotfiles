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
  ];

  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      ferdium
      telegram-desktop # Cliente oficial de escritorio para la aplicación de mensajería Telegram
      newsflash # Lector de noticias RSS/Atom moderno para el escritorio GNOME
      newsboat
    ];
  };
}
