# NixOS Modules

This directory contains system modules that are applied globally on the host. Each module handles a specific aspect of the operating system configuration.

## Modules

### `default.nix`
Aggregator module that imports all system modules: audio, disk, file-manager, fonts, greetd, networking and wayland.

### `kernel.nix`
Configures the **CachyOS** kernel optimized for performance. Includes Intel i915 modules in the initrd, KVM (Intel) kernel module, tuned kernel parameters and sysctl values (`vm.swappiness` 180 for zram, watermark tuning). Sets up **ZramSwap** with zstd compression (50% of RAM) plus a 4GB swap file, and **Plymouth** with the mac-style theme. This kernel is used instead of the standard NixOS kernel for better responsiveness, improved resource management and optimizations for modern hardware.

### `wayland.nix`
Enables **Niri** as the Wayland compositor and configures the ecosystem: XDG portals (GTK default, Thunar file chooser for Niri), Intel GPU driver stack with VAAPI, screenshot tools (grim, slurp, satty), clipboard tools (wl-clipboard, cliphist), notifications (swaynotificationcenter, libnotify), the fuzzel launcher, swayimg image viewer, wlogout and playerctl, plus Wayland compatibility environment variables. Niri is chosen for its unique scroll-stacking approach which offers a different experience compared to traditional tiling window managers.

### `greetd.nix`
Configures **greetd** with **tuigreet** as the login manager, launching the Niri session. It is used instead of heavier options like GDM or SDDM because it is minimal, lightweight and integrates perfectly with Wayland without unnecessary graphical dependencies.

### `audio.nix`
Configures **PipeWire** as the system audio server with ALSA (including 32-bit support) and PulseAudio compatibility, plus `alsa-utils` and `pavucontrol`. PipeWire replaces older solutions offering lower latency, better device management and unification of desktop and professional audio.

### `disk.nix`
Configures GRUB as the bootloader, Nix optimizations (automatic garbage collection weekly, cleanup of generations older than 7 days, store optimization, download/HTTP tuning and free space guarantees) and disk health monitoring with smartd for `/dev/sda`. This keeps the system clean automatically and detects disk failures before data loss occurs.

### `fonts.nix`
Installs system fonts: Noto fonts, Iosevka Nerd Font, CJK sans/serif fonts, DejaVu and Microsoft Core Fonts. These are installed to ensure proper text rendering in any language and icon support in the terminal.

### `file-manager.nix`
Configures **Thunar** as the file manager with archive and volume management plugins, gvfs and thumbnail generation via tumbler, plus file-roller and unrar. Chosen for being lightweight and functional without the heaviness of Nautilus or Dolphin.

### `networking.nix`
Configures **NetworkManager** (nm-applet is enabled in `configuration.nix`), hostname, firewall with ping allowed, systemd-resolved, **Tailscale** and **Cloudflare WARP** with a split-tunnel rule so Tailscale traffic bypasses WARP. Allows secure remote access and VPN usage without a root password.

## Services

System services (Vaultwarden, Firefly III, SearXNG, SSH, Discord bots, backups) live in the sibling `services/` directory. See the [README](../services/README.md) there for more details.