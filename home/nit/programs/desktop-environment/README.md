# Desktop Environment

This module configures all components of the Wayland-based desktop environment. It includes the window manager, status bar, screen locker, idle management, color adjustment and animated wallpapers.

## Files

### `default.nix`
Aggregator module that imports all desktop environment configurations: niri, eww, swaylock, swayidle, gammastep and theming. Installs libcanberra for system sounds and enables the **awww** wallpaper service (replacement for mpvpaper).

### `niri/niri.nix`
Full **Niri** window manager configuration. Imports `binds.nix` and `window-rules.nix`, includes the `blur.kdl` file, configures keyboard layout (`us`/`altgr-intl`), cursor hiding, a 1920x1080@120 scaled display, 12px gaps, column presets, shadows/borders and startup spawns (smile, fcitx5). Niri is chosen for its scroll-stacking model which combines the best of tiling managers with a more fluid and intuitive workflow.

- `binds.nix`: extensive keybinds for launching apps, navigation, layout control, screenshots, media control, gammastep toggling and many custom spawn scripts (YouTube, Nix search, Warn user, torrents, power menu).
- `window-rules.nix`: window-specific rules and per-application transparency settings.
- `blur.kdl`: blur settings included into the Niri config.

### `eww.nix`
Configures **EWW** (ElKowar's Wacky Widgets) as the status bar and custom widgets. Runs as a systemd user service, opens the bar on start and deploys helper scripts (`vscbot`, `network`, `niri-window`).

### `theming.nix`
Configures **Stylix** with the **Catppuccin Mocha** theme to apply a consistent look across all applications automatically. Includes GTK dark mode, Papirus-Dark icons (pink variant), ManhattanCafe cursor (24px) and Geist Sans + JoyPixels fonts.

### `swaylock.nix`
Enables **Swaylock** as the screen locker. It is the standard locker for Wayland environments, lightweight and customizable.

### `swayidle.nix`
Configures **Swayidle** for idle management: locks the screen after ~595 seconds (with a "Locking in 5 seconds" notification) and turns off the display at 1200 seconds. Stops gammastep before sleep and restarts it on unlock. Included to save energy and protect the screen.

### `gammastep.nix`
Configures **Gammastep** for automatic screen color temperature adjustment based on Caracas location. Day temperature 6500K, night temperature 2500K, with night brightness at 80%. Included to reduce blue light at night and prevent eye strain during nighttime computer use.

### `manhattan-cafe.nix`
Defines a custom package for the **ManhattanCafe** cursor theme built from the assets package, matching the overall desktop aesthetic.