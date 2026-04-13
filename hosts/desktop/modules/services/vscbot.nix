{
  config,
  pkgs,
  ...
}: let
  workingDirectory = "/var/lib/discord-bots/vscbot";
in {
  systemd.services.vscbot = {
    enable = true;
    description = "Discord Bot: VSCBot";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      #User = "discord-bot";
      User = "nit";
      Group = "users";
      WorkingDirectory = workingDirectory;
      ExecStart = ''
        ${pkgs.nodejs_latest}/bin/node .
      '';
      EnvironmentFile = config.sops.secrets."discord_bots/vscbot/environmentFile".path;
      Restart = "on-failure";
      RestartSec = 5;
      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}
