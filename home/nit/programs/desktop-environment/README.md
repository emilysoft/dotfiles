# Desktop Environment

This module configures all components of the Wayland-based desktop environment. It includes the window manager, status bar, screen locker, idle management, color adjustment and animated wallpapers.

## Files

### `default.nix`
Aggregator module that imports all desktop environment configurations: niri, eww, swaylock, swayidle, gammastep, mpvpaper and theming. Installs libcanberra for system sounds.

### `niri.nix`
Full **Niri** window manager configuration: keyboard layout (us/intl), cursor hiding while typing, dual monitor setup, 12px gaps, window rules and extensive keybinds for all actions. Niri is chosen for its scroll-stacking model which combines the best of tiling managers with a more fluid and intuitive workflow.

### `eww.nix`
Configures **EWW** (ElKowar's Wacky Widgets) as the status bar and custom widgets. Runs as a systemd user service and displays system information elegantly.

### `theming.nix`
Configures **Stylix** with the **Catppuccin Mocha** theme to apply a consistent look across all applications automatically. Includes Papirus-Dark icons (pink variant), ManhattanCafe cursor (24px) and Geist Sans + JoyPixels fonts.

### `swaylock.nix`
Enables **Swaylock** as the screen locker. It is the standard locker for Wayland environments, lightweight and customizable.

### `swayidle.nix`
Configures **Swayidle** for idle management: locks screen at 595 seconds and turns off display at 1200 seconds. Controls mpvpaper and gammastep on suspend and resume events. Included to save energy and protect the screen.

### `gammastep.nix`
Configures **Gammastep** for automatic screen color temperature adjustment based on Caracas location. Day temperature 6500K, night temperature 2500K. Included to reduce blue light at night and prevent eye strain during nighttime computer use.

### `mpvpaper.nix`
Enables **MPVPaper** for animated video wallpapers. Used for dynamic wallpapers that bring the desktop to life without the overhead of heavier solutions.

### `manhattan-cafe.nix`
Defines a custom package for the **ManhattanCafe** cursor theme that matches the overall desktop aesthetic.

## Directories

| Directory | Description |
|---|---|
| `eww/` | Contains Eww widget configuration (eww.yuck, eww.scss and scripts). |
| `niri/` | Additional Niri configuration directory. |
