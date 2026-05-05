# User Programs

This directory contains modules that install and configure programs for the `nit` user. Programs are organized by category to keep the configuration modular and easy to maintain.

## Structure

| File/Directory   | Description                                                                                                                                                                    |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `default.nix`    | Entry point. Defines the `mis-modulos.profile-principal.enable` option which acts as a master switch to activate the full set of applications. Imports all program categories. |
| `overlays.nix`   | Defines custom overlays for nixpkgs with packages not available in official repositories or requiring specific customizations.                                                 |
| `essentials.nix` | Installs essential daily-use tools: btop, sops, age, gnupg, zellij, rclone. Also imports nvim and alacritty configurations.                                                    |
| `assets.nix`     | Defines a custom package with desktop visual assets (wallpapers, cursors, sounds) fetched from GitHub.                                                                         |

## Program Categories

| Category               | Content                                                                                       |
| ---------------------- | --------------------------------------------------------------------------------------------- |
| `communication/`       | Messaging and communication apps (Vesktop, Ferdium, Telegram, RSS readers).                   |
| `desktop-environment/` | Desktop environment components (Niri, Eww, Swaylock, Swayidle, Gammastep, MPVPaper, theming). |
| `terminal/`            | Terminal tools and emulators (Alacritty, yazi, fzf, btop, and over 27 CLI tools).             |
| `developing/`          | Development tools (Neovim, Node.js, Python, pawncc, sampctl).                                 |
| `utilities/`           | Utility and productivity applications (flameshot, qbittorrent, Obsidian, and over 32 apps).   |
| `gaming/`              | Gaming platforms and tools (Steam, Heroic, MangoHud).                                         |
| `media/`               | Multimedia applications (OBS, Kdenlive, GIMP, Audacity, MPV, Spicetify).                      |
| `office/`              | Office applications (Obsidian, OnlyOffice, SpeedCrunch, Readest).                             |
