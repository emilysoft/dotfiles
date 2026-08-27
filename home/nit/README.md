# Home Manager Configuration - User nit

This directory contains all user configuration managed by Home Manager. Unlike NixOS modules that require root privileges, these modules apply only to the `nit` user and manage personal programs, configurations and services.

## Files

| File | Description |
|---|---|
| `home.nix` | Main entry point. Configures username, home directory, state version (25.11), session variables (EDITOR=nvim, TERMINAL=alacritty), enables sops-nix, EasyEffects, OBS Studio and opencode, and imports all program, git and service modules. |
| `git.nix` | Configures git with conditional identities: emilysoft identity for `~/.dotfiles` and `~/Projects/emilysoft`, neetoons identity for `~/Projects/neetoons`. Also deploys the emilysoft SSH key from sops. |
| `mimeapps.nix` | Defines default application associations for each file type (web, images, video, audio, text, etc.). |

## Directories

| Directory | Description |
|---|---|
| `programs/` | Contains all program modules organized by category (communication, terminal, development, gaming, media, etc.). |
| `services/` | Contains user service modules (clipboard, waypaper, alarms, notifications, etc.). |