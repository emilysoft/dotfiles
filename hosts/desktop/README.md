# Desktop Host Configuration

This directory contains the main configuration for the `nixos` host. It defines hardware, system modules, and general operating system configuration.

## Files

| File | Description |
|---|---|
| `configuration.nix` | Main host configuration. Imports the vscbot module, sops-nix, hardware config, system modules and services. Defines the `nit` user (networkmanager, wheel, video, render groups) with fish shell, enables fish, gamemode, localsend, dconf and nm-applet, sets up rtkit + polkit, timezone (America/Caracas), locale (en_US with es_VE extras) and Flakes experimental features. |
| `hardware-configuration.nix` | Auto-generated hardware configuration by the NixOS installer plus manual tweaks. Imports the CachyOS kernel module, Intel microcode, redistributable firmware and TRIM. |
| `sops.nix` | Integration with sops-nix for decrypting secrets using age. Points to the age key file at `/home/nit/.config/sops/age/keys.txt` and the `secrets/secrets.yaml` file. |

## System Modules

System modules are located in the `modules/` directory:

- **Individual modules**: audio, disk, fonts, file manager, networking, Wayland, greetd and kernel (CachyOS).
- **Services**: located in `services/` and include Vaultwarden, Firefly III, SearXNG, SSH, Discord bots and backups.