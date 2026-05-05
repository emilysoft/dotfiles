# Home Manager Configuration - User nit

This directory contains all user configuration managed by Home Manager. Unlike NixOS modules that require root privileges, these modules apply only to the `nit` user and manage personal programs, configurations and services.

## Files

| File | Description |
|---|---|
| `home.nix` | Main entry point. Configures username, home directory, git configuration, session variables (EDITOR=nvim, TERMINAL=alacritty) and imports all program and service modules. |
| `mimeapps.nix` | Defines default application associations for each file type (web, images, video, audio, text, etc.). |

## Directories

| Directory | Description |
|---|---|
| `programs/` | Contains all program modules organized by category (communication, terminal, development, gaming, media, etc.). |
| `services/` | Contains user service modules (clipboard, wallpapers, notifications, etc.). |
