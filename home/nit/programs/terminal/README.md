# Terminal

This module configures the terminal emulator and all CLI tools installed for the user. It provides a complete and productive terminal environment.

## Files

### `default.nix`
When the profile is enabled, enables **rmpc** (MPD terminal client) and installs over 20 CLI tools:

- **File management**: eza, tree, fd, ncdu, qdirstat, sorter (Downloads organizer), zip/unzip, unrar
- **Monitoring**: bottom, cava
- **Search**: fzf, sherlock, jq
- **Development**: gh (GitHub CLI), lazygit
- **Multimedia**: ffmpeg, yt-dlp
- **Misc**: tty-clock, fastfetch, disfetch, cmatrix, wget

These tools cover all terminal workflow needs from file management to development and entertainment.

### `alacritty.nix`
Configures **Alacritty** as the terminal emulator using the alacritty-graphics package. Catppuccin Mocha color scheme with dark background #1c1c2b, 30% window opacity and blur. Alacritty is chosen for being the fastest terminal emulator available, with GPU acceleration and minimal YAML configuration.