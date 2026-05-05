# Desktop Host Configuration

This directory contains the main configuration for the `nixos` host. It defines hardware, system modules, and general operating system configuration.

## Files

| File | Description |
|---|---|
| `configuration.nix` | Main host configuration. Imports all system modules, defines users (nit, discord-bot), enables fish, gamemode, localsend, dconf, GPG agent, timezone (America/Caracas) and locale (es_VE). |
| `hardware-configuration.nix` | Auto-generated hardware configuration by the NixOS installer. Defines filesystems, Intel microcode, firmware and TRIM. Imports the CachyOS kernel configuration. |
| `sops.nix` | Integration with sops-nix for decrypting secrets using age. Deploys the user's SSH key. |

## System Modules

System modules are located in the `modules/` directory and are divided into two categories:

- **Individual modules**: audio, disk, fonts, file manager, networking, virtualization, Wayland, greetd and kernel.
- **Services**: located in `modules/services/` and include Vaultwarden, Firefly III, Discord bots, backups and more.
