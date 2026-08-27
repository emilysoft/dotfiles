# System Services

This directory contains modules for services that run at the system level. These services are available to all users and start automatically with the system.

## Services

### `default.nix`
Aggregator module that imports all service sub-modules: ssh, xwayland-satellite, vaultwarden, discord_bots_backup, firefly-iii and searxng. Enables the **vscbot** Discord bot (via the `inputs.vscbot` NixOS module, on port 3006 with its environment file decrypted from sops) and limits journald to 500MB to prevent logs from consuming too much disk space.

### `vaultwarden.nix`
Configures **Vaultwarden** (self-hosted Bitwarden) on port 8222 with **Caddy** as a reverse proxy and TLS via Tailscale. Includes encrypted daily backups using gnupg and rclone, synced to Google Drive at 04:00. Self-hosting Vaultwarden provides full control over passwords without relying on external services.

### `firefly-iii.nix`
Configures **Firefly III** as a personal finance manager with SQLite, served via **nginx** on port 9080 (host `firefly.local`). Included for tracking expenses and income in a private, self-hosted manner.

### `searxng.nix`
Configures **SearXNG** as a private metasearch engine, bound to `127.0.0.1:8080` with DuckDuckGo autocomplete, safe search off and the secret key injected from sops. Integrated with the `Mod+G` search binding in Niri.

### `ssh.nix`
Enables **OpenSSH** on port 22 without password authentication and with root login disabled. Also configures the `nit` user's SSH client aliases for the emilysoft (GitHub/Codeberg) and neetoons (GitHub) identities.

### `discord_bots_backup.nix`
User systemd timer for rotating backups of Discord bots, running daily at 04:30. Uses sqlite, rclone, gzip and tar to maintain automatic backups.

### `xwayland-satellite.nix`
Configures **Xwayland-satellite** as a service to improve X11 application compatibility under Wayland. Some X11 applications behave better with satellite than with standard Xwayland.