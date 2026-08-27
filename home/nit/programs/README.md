# User Programs

This directory contains modules that install and configure programs for the `nit` user. Programs are organized by category to keep the configuration modular and easy to maintain.

## Structure

| File/Directory   | Description                                                                                                                                                                    |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `default.nix`    | Entry point. Defines the `mis-modulos.profile-principal.enable` and `mis-modulos.media.enable` options. Imports all program categories and installs the Zen Browser and Concord. |
| `overlays.nix`   | Defines custom overlays for nixpkgs with packages not available in official repositories or requiring specific customizations (sorter, recorder, assets, manhattan-cafe, lutris). |
| `essentials.nix` | Installs essential daily-use tools: btop, sops, age, gnupg, zellij, rclone, smile, tauon, losslesscut-bin, proton-vpn, waypaper and recorder. Also imports nvim, alacritty and yazi configurations. |
| `assets.nix`     | Defines a custom package with desktop visual assets (wallpapers, cursors, sounds) fetched from GitHub.                                                                         |

## Program Categories

| Category               | Content                                                                                       |
| ---------------------- | --------------------------------------------------------------------------------------------- |
| `communication/`       | Messaging and communication apps (Vesktop/Nixcord, Ferdium, Telegram, Newsboat).              |
| `desktop-environment/` | Desktop environment components (Niri, Eww, Swaylock, Swayidle, Gammastep, awww, theming).     |
| `terminal/`            | Terminal tools and emulators (Alacritty, yazi, rmpc and over 20 CLI tools).                   |
| `developing/`          | Development tools (Neovim, Node.js, Python, Bun, Godot, sampctl).                             |
| `utilities/`           | Utility applications (qbittorrent, Tor Browser, bleachbit, contrast).                         |
| `gaming/`              | Gaming platforms and tools (Steam, Heroic, Lutris, RetroArch, Ruffle, MangoHud).              |
| `media/`               | Multimedia applications (Kdenlive, GIMP, Audacity, LMMS, Mixxx, MPV, Spicetify).              |
| `office/`              | Office applications (Obsidian, OnlyOffice, Anki, Gedit, Readest).                             |