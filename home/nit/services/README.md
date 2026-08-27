# User Services

This directory contains modules for services that run at the user level. These services are personal and do not require root privileges. They start automatically when the user logs in.

## Files

### `services.nix`
Aggregator module that imports all service sub-modules: waypaper, clipboard, clean-cache, sorter, discord-rpc-manager and alarmas. Enables **Dunst** as the notification daemon and **hyprpolkitagent** for graphical polkit authentication. Dunst is chosen for being lightweight, customizable and Wayland-compatible.

### `waypaper.nix`
Configures **Waypaper** as a systemd user service for wallpaper management. Restores the wallpaper from the assets package on login using the **awww** backend (successor of mpvpaper).

### `clipboard.nix`
Configures clipboard history with **wl-paste + cliphist** integration. Monitors text paste events and stores them so previously copied items can be accessed (bound to `Mod+T` in Niri).

### `clean-cache.nix`
Configures a systemd timer for daily cleanup of the **Spotify** cache. Included to prevent the cache from growing indefinitely and consuming disk space unnecessarily.

### `sorter.nix`
Configures a systemd timer that runs the `sorter` script on ~/Downloads every 30 minutes to automatically organize files by type.

### `discord-rpc-manager.nix`
Configures **Discord RPC Manager** with two components built from GitHub: a Node.js daemon (tsx) and a GTK4/Libadwaita GUI (gjs). Allows customizing the activity displayed on Discord (Rich Presence) to show what music is playing or what program is being used.

### `alarmas.nix`
Configures an **alarm/scheduler** (CSV-driven) as a systemd user service plus a timer that runs every minute. Reads a CSV file (`~/.config/alarmas/alarmas.csv`) with entries in `HH:MM,days,message,command` format and fires notifications or launches commands when the time matches (e.g., wake-up at 08:00, meal reminder at 12:30, weekend gaming session at 15:00).

### Additional user services
- **EasyEffects** audio processing is enabled directly in `home/nit/home.nix` (`services.easyeffects.enable`), running as a service started after pipewire with automatic restart.
- **Notificador/polkit**: `hyprpolkitagent` runs the graphical polkit agent on login.