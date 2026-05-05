# Communication

This module configures the user's messaging and communication applications. The goal is to centralize all communication channels into a manageable set of apps.

## Files

### `default.nix`
When the main profile is enabled, installs **Ferdium** (messaging service aggregator), **Telegram Desktop**, **Newsflash** (GUI RSS reader) and **Newsboat** (terminal RSS reader). Included to centralize communication and stay informed through RSS feeds.

### `vesktop.nix`
Configures **Vesktop** as the Discord client via **nixcord**. Uses the Catppuccin Mocha Pink theme. Enables plugins like messageLogger, typingIndicator, silentTyping, serverInfo, fakeNitro and noBlockedMessages. Vesktop is chosen for being a Linux-optimized Discord client with better performance and compatibility than the official client.

### `ferdium.nix`
Defines a custom package for **Ferdium v7.1.1** built from a .deb. Ferdium allows centralizing multiple messaging services (WhatsApp, Slack, Teams, etc.) into a single window, avoiding multiple apps open and consuming resources.

### `discord-desktop-mobile.nix`
Custom package for **discord-desktop-mobile** fetched from GitHub. Provides a Discord interface with a mobile app look for a different experience.
