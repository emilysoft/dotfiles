{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/nit/.config/sops/age/keys.txt";
    secrets = {
      "discord_bots/vscbot/environmentFile" = {};
      "discord_bots/neetoons/environmentFile" = {};
      "vaultwarden_key" = {};
      "vaultwarden-backup-env" = {
        owner = "root";
      };
      "github/neetoons/ssh_key" = {
        path = "/home/nit/.ssh/id_ed25519";
        owner = "nit";
        mode = "0600";
      };
    };
  };
}
