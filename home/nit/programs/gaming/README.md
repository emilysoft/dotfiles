# Gaming

This module configures gaming platforms and performance monitoring tools for gaming on Linux.

## Files

### `default.nix`
When the profile is enabled, installs:

- **Heroic Games Launcher**: client for Epic Games Store and GOG, allowing access to game libraries from these platforms on Linux.
- **Steam**: the most popular gaming platform with Proton support that enables running Windows games on Linux.

Both platforms are included to have access to the widest possible game library from Linux.

### `mangohud.nix`
Configures **MangoHud** as a session-wide performance overlay. Displays FPS, CPU/GPU stats, RAM/VRAM, power consumption, architecture, wine version, resolution, gamemode and vkbasalt. The HUD is positioned top-center in horizontal format and is toggled with F12. It is disabled for mpv. Used to monitor performance in games and graphics applications in real time and detect bottlenecks.

## Directories

| Directory | Description |
|---|---|
| `MangoHud/` | Contains the `MangoHud.conf` file with the custom performance overlay configuration. |
