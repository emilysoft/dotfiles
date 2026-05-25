{pkgs, ...}: let
  browser = "zen-beta.desktop";
in {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # --- Navegación y Web ---
      "text/html" = [browser];
      "x-scheme-handler/http" = [browser];
      "x-scheme-handler/https" = [browser];
      "x-scheme-handler/about" = [browser];
      "x-scheme-handler/unknown" = [browser];
      "application/pdf" = [browser];
      "image/webp" = ["swayimg.desktop"];

      # --- Desarrollo y Texto ---
      "text/plain" = ["gedit.desktop"];
      "text/md" = ["gedit.desktop"];
      "application/json" = ["gedit.desktop"];
      "text/x-csrc" = ["nvim.desktop"];
      "application/x-wine-extension-ini" = ["gedit.desktop"];
      "application/x-wine-extension-pwn" = ["nvim.desktop"];
      "application/x-desktop" = ["nvim.desktop"];

      # --- Archivos y Sistema ---
      "inode/directory" = ["thunar.desktop"];
      "application/x-gnome-saved-search" = ["thunar.desktop"];
      "application/x-rar" = ["org.gnome.FileRoller.desktop"];
      "application/rar" = ["org.gnome.FileRoller.desktop"];
      "application/vnd.rar" = ["org.gnome.FileRoller.desktop"];
      "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
      "application/zip" = ["org.gnome.FileRoller.desktop"];

      # --- Multimedia ---
      "video/mp4" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/quicktime" = ["mpv.desktop"];
      "audio/mpeg" = ["mpv.desktop"];
      "audio/flac" = ["org.kde.elisa.desktop"];
      "image/jpeg" = ["swayimg.desktop"];
      "image/png" = ["swayimg.desktop"];
      "image/gif" = [browser];

      # --- Protocolos Específicos ---
      "x-scheme-handler/discord" = ["vesktop.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];
      "x-scheme-handler/gitkraken" = ["GitKraken.desktop"];
      "x-scheme-handler/notion" = ["Notion.desktop"];
      "x-scheme-handler/mailto" = [browser];
      "x-scheme-handler/terminal" = ["alacritty.desktop"];
      "terminal-emulator" = ["alacritty.desktop"];
    };

    # Asociaciones añadidas (aparecen en el menú "Abrir con...")
    associations.added = {
      "image/png" = ["gimp.desktop" "pinta.desktop" "satty.desktop"];
      "image/jpeg" = ["pinta.desktop" "gimp.desktop"];
      "video/mp4" = ["fr.handbrake.gnb.desktop" browser "mpv.desktop"];
      "video/webm " = ["fr.handbrake.gnb.desktop" browser "mpv.desktop"];
      "video/x-matroska" = ["fr.handbrake.ghb.desktop" "mpv.desktop"];
      "text/plain" = ["nvim.desktop" "obsidian.desktop"];
      "application/json" = ["nvim.desktop"];
    };
  };
}
