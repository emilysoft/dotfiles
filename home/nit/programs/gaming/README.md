# Gaming

This module configures gaming platforms and performance monitoring tools for gaming on Linux.

## Files

### `default.nix`
When the profile is enabled, installs:

- **Heroic Games Launcher**: client for Epic Games Store and GOG, allowing access to game libraries from these platforms on Linux.
- **Steam**: the most popular gaming platform with Proton support that enables running Windows games on Linux.
- **Ruffle**: Flash Player emulator for playing legacy Flash games.
- **Lutris**: game manager that unifies sources from Steam, GOG and others (from the stable nixpkgs via overlay).

These platforms are included to have access to the widest possible game library from Linux.

### `mangohud.nix`
Configures **MangoHud** as a session-wide performance overlay. Displays FPS, CPU/GPU stats, RAM/VRAM, power consumption, gamemode and media player info. The HUD is positioned top-center in horizontal format and is toggled with F12. It is disabled for mpv and excluded from Stylix theming. Used to monitor performance in games and graphics applications in real time and detect bottlenecks.

### `retroarch.nix`
Enables **RetroArch** with the Vulkan video driver, 21:9 aspect ratio, structured save states and the swanstation and beetle-psx-hw (PlayStation 1) cores.

## Directories

| Directory | Description |
|---|---|
| `MangoHud/` | Legacy `MangoHud.conf` file; the overlay is now configured entirely via `home-manager` settings. |