{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = ["gtk" "gnome"];
      };
      niri = {
        "org.freedesktop.impl.portal.FileChooser" = ["thunar"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    #GStreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav

    # --- Entorno de Escritorio y Complementos (Wayland/Sway) ---
    fuzzel #FIXME por modular
    swaynotificationcenter
    swayimg #FIXME por modular # Visor de imágenes
    libnotify # Biblioteca para enviar notificaciones de escritorio
    wlogout # wlogout is a logout menu for wayland environments.

    # --- Herramientas de Terminal y Clipboard ---
    cliphist #FIXME por modular # Herramienta de historial de portapapeles para Wayland
    wl-clipboard # Herramientas de línea de comandos para manipular el portapapeles de Wayland
    # --- Captura de Pantalla y Manipulación de Imágenes (Wayland) ---
    grim # Utilidad para tomar capturas de pantalla en Wayland
    slurp # Utilidad para seleccionar una región rectangular de la pantalla en Wayland
    satty # edicion de captura

    # --- Audio, Media y Utilidades de Red ---
    playerctl # Utilidad de línea de comandos para controlar reproductores de medios compatibles con MPRIS
  ];

  services.xserver.videoDrivers = ["modesetting"];

  hardware.graphics = {
    enable32Bit = true;
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
    NIXOS_OZONE_WL = "1";
    GSK_RENDERER = "opengl";
    VDPAU_DRIVER = "va_gl";
    ELECTRON_FLAGS = "--disable-gpu-compositing --disable-gpu-rasterization";
    WLR_DRM_DEVICES = "/dev/dri/by-path/pci-0000:00:02.0-render";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  services.dbus.enable = true;
  programs.xwayland.enable = true;
}
