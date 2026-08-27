# Utilities

This module installs utility applications for the user.

## Files

### `default.nix`
When the profile is enabled, installs:

- **Files**: qbittorrent (BitTorrent client)
- **Browsing**: tor-browser (privacy-focused browser)
- **System**: bleachbit (system cleaner), contrast (contrast checker)

The rest of the productivity and utility apps (Obsidian, Anki, Proton VPN, recorder, waypaper, etc.) live in their respective category modules and in `essentials.nix`.

### `sorter.nix`
Defines a custom package for **sorter**, a bash script that automatically organizes the Downloads folder by sorting files by type. Included to keep the downloads folder clean without manual intervention.

## Directories

| Directory | Description |
|---|---|
| `sorter/` | Contains the `sorter.sh` script that performs automatic file organization. |