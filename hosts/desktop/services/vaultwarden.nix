{
  config,
  pkgs,
  ...
}: let
  backupScript = pkgs.writeShellScriptBin "vaultwarden-backup-script" (builtins.readFile ./vault_backup.sh);
in {
  sops.secrets = {
    "vaultwarden_key" = {};
    "vaultwarden-backup-env" = {
      owner = "nit";
    };
  };

  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    environmentFile = config.sops.secrets."vaultwarden_key".path;
    config = {
      DOMAIN = "https://nixos.siren-larch.ts.net";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
      SIGNUPS_ALLOWED = false;
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."nixos.siren-larch.ts.net" = {
      extraConfig = ''
        tls {
          get_certificate tailscale
        }
        encode zstd gzip
        reverse_proxy localhost:8222
      '';
    };
  };

  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = ["--operator=caddy"];
  systemd.services.caddy.serviceConfig = {
    AmbientCapabilities = ["CAP_NET_BIND_SERVICE"];
    CapabilityBoundingSet = ["CAP_NET_BIND_SERVICE"];
  };

  # Backup
  systemd.services.vaultwarden-upload-gdrive = {
    description = "Cifra y sube el backup local de Vaultwarden a Google Drive";
    after = ["network-online.target" "backup-vaultwarden.service"];
    wants = ["network-online.target"];
    serviceConfig = {
      Type = "oneshot";
      User = "nit";
      Group = "vaultwarden";
      EnvironmentFile = config.sops.secrets."vaultwarden-backup-env".path;
    };
    path = with pkgs; [
      gnupg
      rclone
      coreutils
      gnutar
      gzip
    ];
    script = "${backupScript}/bin/vaultwarden-backup-script";
    startAt = "04:00";
  };
}
