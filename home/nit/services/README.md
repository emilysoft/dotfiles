# User Services

This directory contains modules for services that run at the user level. These services are personal and do not require root privileges. They start automatically when the user logs in.

## Files

### `services.nix`
Aggregator module that imports all service sub-modules: waypaper, clipboard, rclone, clean-cache, sorter and discord-rpc-manager. Enables **Dunst** as the notification daemon. Dunst is chosen for being lightweight, customizable and Wayland-compatible.

### `waypaper.nix`
Configures **Waypaper** as a systemd user service for wallpaper management. Restores the wallpaper from assets using the mpvpaper backend on login.

### `clipboard.nix`
Configures clipboard history with **wl-paste + cliphist** integration. Monitors text paste events and stores them so previously copied items can be accessed.

### `rclone.nix`
Configures **Google Drive** mounting via rclone as a systemd user service. Mounts the `nit:` remote to ~/GoogleDrive with VFS cache for writes. Allows accessing Google Drive files as if they were local without syncing all content.

### `clean-cache.nix`
Configures a systemd timer for daily cleanup of the **Spotify** cache. Included to prevent the cache from growing indefinitely and consuming disk space unnecessarily.

### `sorter.nix`
Configures a systemd timer that runs the `sorter` script on ~/Downloads every 5 minutes to automatically organize files by type.

### `discord-rpc-manager.nix`
Configures **Discord RPC Manager** with two components built from GitHub: a Node.js daemon (tsx) and a GTK4/Libadwaita GUI (gjs). Allows customizing the activity displayed on Discord (Rich Presence) to show what music is playing or what program is being used.

### `easyeffects.nix`
Configures **EasyEffects** for audio processing as a systemd user service, started after pipewire with automatic restart. Used for real-time audio equalization and effects for both microphone and audio output.

### `gestor_horario.nix`
Configures a **schedule manager** with two systemd timers:

- **rutina-manana**: at 07:00, opens the daily workflow
- **rutina-tarde**: at 18:00, closes the workflow

Included to automate daily routines and maintain a productive schedule, opening and closing applications depending on the time of day.
