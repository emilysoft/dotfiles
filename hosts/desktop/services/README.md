# System Services

This directory contains modules for services that run at the system level. These services are available to all users and start automatically with the system.

## Services

### `services.nix`
Aggregator module that imports all service sub-modules. Enables **MariaDB** as a local database server for applications that require it. Configures **MPD** (Music Player Daemon) with PipeWire output for background music playback. Enables **OpenSSH** without password authentication for security. Enables **Flatpak** as an additional application source. Limits journald to 500MB to prevent logs from consuming too much disk space.

### `vaultwarden.nix`
Configures **Vaultwarden** (self-hosted Bitwarden) on port 8222 with **Caddy** as a reverse proxy and TLS via Tailscale. Includes encrypted daily backups using sqlite, gnupg and rclone. Self-hosting Vaultwarden provides full control over passwords without relying on external services.

### `firefly-iii.nix`
Configures **Firefly III** as a personal finance manager with SQLite, served via **nginx** on port 9080. Included for tracking expenses and income in a private, self-hosted manner.

### `neetoons-bot.nix`
Systemd service for the **"Neetoons"** Discord bot. Runs as the `discord-bot` user via Node.js with secrets managed via sops.

### `vscbot.nix`
Systemd service for the **"VSCBot"** Discord bot. Runs as the `nit` user via Node.js with secrets managed via sops.

### `discord_bots_backup.nix`
User systemd timer for rotating backups of Discord bots, running daily at 04:30. Uses sqlite, rclone, gzip and tar to maintain automatic backups.

### `xwayland-satellite.nix`
Configures **Xwayland-satellite** as a user service to improve X11 application compatibility under Wayland. Some X11 applications behave better with satellite than with standard Xwayland.
