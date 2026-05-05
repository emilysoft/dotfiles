# Utilities

This module installs utility and productivity applications for the user. It covers everything from security to image editing, file management and study tools.

## Files

### `default.nix`
When the profile is enabled, installs over 32 GUI applications:

- **Security**: keepassxc (password manager), proton-vpn
- **Screenshots**: flameshot
- **Files**: qbittorrent, nicotine-plus (Soulseek), p7zip, peazip, zstd, warehouse (Flatpak)
- **Browsing**: qutebrowser (keyboard-driven)
- **Productivity**: appflowy (Notion alternative), Obsidian (notes), pandoc (document conversion), texliveFull (LaTeX), trilium-desktop (hierarchical notes), sticky-notes
- **Editing**: video-trimmer, gedit, smile (emojis)
- **System**: waypaper (wallpapers), bleachbit (cleaning), contrast (accessibility), gnome-logs, gnome-clocks, gnome-font-viewer, gnome-decoder
- **Study**: anki-bin (flashcards), solanum (pomodoro)
- **Gaming**: protonup-qt (Proton GE)
- **Calculation**: SpeedCrunch
- **Reading**: Readest (e-reader)
- **Translation**: dialect, wordbook
- **Backups**: pika-backup
- **Recording**: recorder
- **Office**: OnlyOffice Desktop Editors

This collection covers all daily productivity needs without relying on cloud services.

### `sorter.nix`
Defines a custom package for **sorter**, a bash script that automatically organizes the Downloads folder by sorting files by type. Included to keep the downloads folder clean without manual intervention.

## Directories

| Directory | Description |
|---|---|
| `sorter/` | Contains the `sorter.sh` script that performs automatic file organization. |
