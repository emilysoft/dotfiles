{
  config,
  pkgs,
  ...
}: let
  workingDirectory = "/var/lib/discord-bots/neetoons-bot";
in {
  sops.secrets."discord_bots/neetoons/environmentFile" = {};
  systemd.services.neetoons-bot = {
    enable = true;
    description = "Discord Bot: Neetoons";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      User = "discord-bot";
      Group = "users";
      WorkingDirectory = workingDirectory;
      ExecStart = ''
        ${pkgs.nodejs_latest}/bin/node .
      '';

      EnvironmentFile = config.sops.secrets."discord_bots/neetoons/environmentFile".path;
      Restart = "on-failure";
      RestartSec = 5;
      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}
