# Communication

This module configures the user's messaging and communication applications. The goal is to centralize all communication channels into a manageable set of apps.

## Files

### `default.nix`
When the main profile is enabled, installs **Ferdium** (messaging service aggregator, built from a custom flake) and **Telegram Desktop**. Vesktop and Newsboat are configured by their own modules below. Included to centralize communication and stay informed through RSS feeds.

### `vesktop.nix`
Configures **Vesktop** as the Discord client via **nixcord**. Uses the Catppuccin Mocha Pink theme with frameless mode. Enables a broad set of plugins: messageLogger, typingIndicator, silentTyping, serverInfo, fakeNitro, voiceMessages, tenorGifSearch, youtubeAdblock, spotifyCrack, shikiCodeblocks, whoReacted, viewIcons and many more. Vesktop is chosen for being a Linux-optimized Discord client with better performance and compatibility than the official client.

### `newsboat.nix`
Configures **Newsboat** as the terminal RSS reader with a curated feed list (NixOS, local Venezuelan news, tech and crypto sites) plus a custom keybinding scheme (j/k navigation, l opens, h goes back) and Catppuccin-inspired colors.