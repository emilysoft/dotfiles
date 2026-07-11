{
  config,
  lib,
  ...
}: {
  sops.secrets."firefly-iii" = {
    owner = "nit";
    mode = "0600";
  };

  services.firefly-iii = {
    enable = true;
    user = "nit";
    group = "nginx";
    dataDir = "/var/lib/firefly-iii";
    enableNginx = true;
    virtualHost = "firefly.local";

    poolConfig = {
      "pm" = "static";
      "pm.max_children" = 2;
      "pm.max_requests" = 200;
    };

    settings = {
      APP_ENV = "production";
      APP_KEY_FILE = config.sops.secrets."firefly-iii".path;
      SITE_OWNER = "mail@example.com";
      DB_CONNECTION = "sqlite";

      APP_DEBUG = false;
      LOG_CHANNEL = "daily";
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."${config.services.firefly-iii.virtualHost}" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 9080;
        }
      ];
    };
  };

  systemd.services.firefly-iii-setup = {
    before = lib.mkForce [];
    requiredBy = lib.mkForce [];
  };
}
