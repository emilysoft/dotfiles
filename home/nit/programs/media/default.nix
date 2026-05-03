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
      kdePackages.elisa # The Elisa music player is developed by the KDE community and strives to be simple and pleasant to use.
      mixxx
      lmms # Estación de trabajo de audio digital (DAW) de código abierto
      gimp
      audacity
      pinta # Programa simple para dibujar/editar imágenes, similar a Paint.NET
      gcolor3 # Selector y capturador de color simple para el escritorio
      kdePackages.kdenlive # Editor de video no lineal avanzado
      losslesscut-bin # Editor de video simple para cortes rápidos sin pérdida de calidad
      handbrake
      amberol
      pipeline
      openscreen
      nuclear
    ];
  };
}
