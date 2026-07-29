# AGENTS.md

NixOS dotfiles repository using Flakes + Home Manager. Personal configuration for user `nit`.

## Apply Configuration

```bash
sudo nixos-rebuild switch --flake .#nixos
```

This applies both system-level (`hosts/`) and user-level (`home/`) changes in one command.

## Repository Structure

- `flake.nix` - Entry point. Defines inputs (nixpkgs-unstable, home-manager, sops-nix, niri, stylix, etc.) and outputs.
- `hosts/desktop/` - System-wide NixOS modules (audio, networking, fonts, kernel, services).
- `home/nit/` - Home Manager configuration for user `nit`.
- `secrets/` - Encrypted secrets via sops-nix (age encryption).

## Key Files

- `hosts/desktop/configuration.nix` - Main system config. Imports hardware config, modules, services.
- `home/nit/home.nix` - Main home config. Sets user, session variables, imports programs and services.
- `home/nit/programs/default.nix` - Entry point for all program modules. Defines `mis-modulos.profile-principal.enable` option.
- `home/nit/programs/overlays.nix` - Custom overlays for packages not in nixpkgs (discord-desktop-mobile, sorter, recorder, pawncc, assets, manhattan-cafe, lutris).

## Architecture Notes

- **Two-tier design**: System config (`hosts/`) requires root. User config (`home/`) applies per-user.
- **Conditional git identity**: Git user changes based on directory (`~/.dotfiles` and `~/Projects/emilysoft` use emilysoft identity, `~/Projects/neetoons` uses neetoons identity).
- **Custom packages**: Several packages defined in overlays via `callPackage` (see `home/nit/programs/` subdirectories).
- **Secrets**: Managed via sops-nix. Key file at `/home/nit/.config/sops/age/keys.txt`. Encrypted secrets in `secrets/secrets.yaml`.
- **Services**: System services in `hosts/desktop/services/` (jellyfin, vaultwarden, ssh, etc.). User services in `home/nit/services/` (clipboard, waypaper, dunst, etc.).

## Working with This Repo

- After editing any `.nix` file, run `sudo nixos-rebuild switch --flake .#nixos` to apply.
- To check configuration without applying: `nix build .#nixosConfigurations.nixos.config.system.build.toplevel --dry-run`.
- Secrets are encrypted with age. To edit `secrets/secrets.yaml`, use `sops secrets/secrets.yaml`.
- Custom overlays are in `home/nit/programs/overlays.nix`. When adding a new custom package, define it there and create a corresponding `.nix` file in the appropriate category directory.
- Program categories: `communication/`, `desktop-environment/`, `developing/`, `gaming/`, `media/`, `office/`, `terminal/`, `utilities/`.

## Git Conventions

- Commit messages follow conventional commits: `feat()`, `chore()`, `fix()`, etc.
- Scope in parentheses indicates the area changed (e.g., `feat(virtualisation): add podman`).
