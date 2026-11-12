# Emily's NixOS Configuration

A personal, highly customized NixOS configuration built with **Flakes** and **Home Manager**, featuring a modern Wayland-based desktop environment centered around the **Niri** scroll-stacking window manager.

## Aesthetic and Desktop Environment

*   **Window Manager:** [Niri](https://github.com/YaLTeR/niri) - A scroll-stacking tiling Wayland compositor.
*   **Desktop Shell:** [Noctalia](https://github.com/noctalia-dev/noctalia) - Panels, launcher, notifications, and wallpaper management.
*   **Theming:** Catppuccin Mocha with the mauve accent, applied to GTK and Kvantum.
*   **Icons:** Papirus (Pink variant).
*   **Cursor:** Custom ManhattanCafe theme.
*   **Lockscreen:** Hyprlock.
*   **Idle Management:** Hypridle.
*   **Night Light:** Gammastep.

## Key Features

*   **NixOS Unstable (Rolling):** Tracks `nixpkgs-unstable` with a stable `nixos-26.05` input available.
*   **Optimized Kernel:** Uses the CachyOS kernel with zram swap and a custom Plymouth boot theme.
*   **Modular Design:** Clean separation between system-wide (`hosts/`) and user-specific (`home/`) configurations.
*   **Gaming Ready:** Heroic, Lutris, RetroArch, MangoHud, and GameMode pre-configured.
*   **Development Stack:** Pre-configured with Neovim, Fish shell, Node.js (Latest), Python 3.15, TypeScript, Bun, Godot, and various CLI tools (Yazi, Fzf, Btop, Zellij, Lazygit).
*   **Creative Suite:** OBS Studio, Kdenlive, GIMP (PhotoGIMP), Audacity, and Pinta.
*   **Productivity:** Obsidian for notes, Zen Browser for web, OnlyOffice for documents, Anki, and Readest.
*   **Self-Hosted Services:** Vaultwarden, SearXNG, Ollama, SSH, Xwayland Satellite, and Discord bots.
*   **Automated Backups:** Rclone-based user timers for hot storage, cold storage, and Obsidian vaults.
*   **Secrets Management:** Encrypted secrets via sops-nix and age.

## Repository Structure

```text
.
├── flake.nix               # Entry point for the configuration
├── flake.lock
├── hosts/                  # System-wide configurations
│   └── desktop/            # Configuration for the 'nixos' host
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       ├── sops.nix
│       ├── modules/        # Reusable system modules (audio, networking, etc.)
│       └── services/       # System services (vaultwarden, searxng, etc.)
├── home/                   # Home Manager configurations
│   └── nit/                # User 'nit' configuration
│       ├── home.nix        # Main home entry point
│       ├── git.nix         # Conditional git identities
│       ├── mimeapps.nix    # Default application associations
│       ├── programs/       # Program modules by category
│       ├── services/       # User systemd services and timers
│       └── backups/        # Rclone backup configuration
├── secrets/
│   └── secrets.yaml        # Encrypted secrets (sops-nix)
└── README.md
```

## Key Bindings (Niri)

*   `Mod + X`: Open Alacritty
*   `Mod + Shift + X`: Open Alacritty with Zellij
*   `Mod + S`: Noctalia launcher
*   `Mod + E`: Yazi (File Manager)
*   `Mod + Shift + E`: Thunar (File Manager)
*   `Mod + T`: Clipboard history (cliphist + Fuzzel)
*   `Mod + Q`: Close Window
*   `Mod + H/J/K/L`: Focus Left/Down/Up/Right
*   `Mod + Space`: Toggle Overview
*   `Mod + I`: Lock screen (Hyprlock)
*   `Mod + P`: Start screen recording
*   `Print`: Screenshot
*   `Mod + Print`: Region screenshot with Satty
*   `Mod + Shift + Q`: Quit Niri

## Installation

> [!WARNING]
> This configuration is tailored for specific hardware. Review `hosts/desktop/hardware-configuration.nix` before applying.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/neetoons/dotfiles.git
    cd dotfiles
    ```

2.  **Apply the configuration:**
    ```bash
    sudo nixos-rebuild switch --flake .#nixos
    ```

## Credits

Special thanks to the authors of the following flakes and projects used in this setup:

*   [niri-flake](https://github.com/sodiboo/niri-flake)
*   [noctalia](https://github.com/noctalia-dev/noctalia)
*   [spicetify-nix](https://github.com/Gerg-L/spicetify-nix)
*   [zen-browser-flake](https://github.com/0xc000022070/zen-browser-flake)
*   [nixcord](https://github.com/FlameFlag/nixcord)
*   [nix-cachyos-kernel](https://github.com/xddxdd/nix-cachyos-kernel)
*   [nyx (Chaotic)](https://github.com/chaotic-cx/nyx)
