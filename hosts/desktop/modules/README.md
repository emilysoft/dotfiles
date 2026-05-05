# NixOS Modules

This directory contains system modules that are applied globally on the host. Each module handles a specific aspect of the operating system configuration.

## Modules

### `kernel.nix`
Configures the **CachyOS** kernel optimized for performance. Includes Intel GPU modules, KVM virtualization, ZramSwap with zstd compression and an 8GB swap file. This kernel is used instead of the standard NixOS kernel for better responsiveness, improved resource management and optimizations for modern hardware.

### `wayland.nix`
Enables **Niri** as the Wayland compositor and configures the full ecosystem: XDG portals, Intel GPU drivers, screenshot tools, clipboard, notifications and Wayland compatibility environment variables. Niri is chosen for its unique scroll-stacking approach which offers a different experience compared to traditional tiling window managers.

### `greetd.nix`
Configures **greetd** with **tuigreet** as the login manager. It is used instead of heavier options like GDM or SDDM because it is minimal, lightweight and integrates perfectly with Wayland without unnecessary graphical dependencies.

### `audio.nix`
Configures **PipeWire** as the system audio server with ALSA, PulseAudio and JACK compatibility. PipeWire replaces older solutions offering lower latency, better device management and unification of desktop and professional audio.

### `disk.nix`
Configures GRUB as the bootloader, Nix optimizations (automatic garbage collection, cleanup of old generations) and disk health monitoring with smartd. This keeps the system clean automatically and detects disk failures before data loss occurs.

### `fonts.nix`
Installs system fonts: Noto fonts, Iosevka Nerd Font, CJK fonts, DejaVu and Microsoft Core Fonts. These are installed to ensure proper text rendering in any language and icon support in the terminal.

### `file-manager.nix`
Configures **Thunar** as the file manager with archive plugins, volume management and thumbnail generation. Chosen for being lightweight and functional without the heaviness of Nautilus or Dolphin.

### `networking.nix`
Configures **NetworkManager** with nm-applet, firewall enabled and polkit-gnome for authentication. Allows managing network connections without needing a root password.

### `virtualisation.nix`
Configures **libvirtd** with QEMU/KVM and **GNOME Boxes** for virtual machine management. Included to be able to run other operating systems when needed for testing or development.

### `services/`
Contains system service modules such as Vaultwarden, Firefly III, Discord bots and backups. See the README inside that directory for more details.
