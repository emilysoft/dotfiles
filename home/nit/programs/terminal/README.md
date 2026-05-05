# Terminal

This module configures the terminal emulator and all CLI tools installed for the user. It provides a complete and productive terminal environment.

## Files

### `default.nix`
When the profile is enabled, enables **rmpc** (MPD terminal client) and installs over 27 CLI tools:

- **File management**: yazi, eza, tree, fd, ncdu, qdirstat
- **Monitoring**: btop, bottom
- **Search**: fzf, sherlock
- **Development**: gh (GitHub CLI), jq
- **Multimedia**: ffmpeg, yt-dlp, cava
- **Misc**: tty-clock, fastfetch, disfetch, cmatrix, ghostty
- **Tools**: zip/unzip, unrar, wget, sorter

These tools cover all terminal workflow needs from file management to development and entertainment.

### `alacritty.nix`
Configures **Alacritty** as the terminal emulator using the alacritty-graphics package. Catppuccin Mocha color scheme with dark background #1c1c2b. Alacritty is chosen for being the fastest terminal emulator available, with GPU acceleration and minimal YAML configuration.
