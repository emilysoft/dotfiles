{
  config,
  lib,
  ...
}: {
  sops.secrets."firefly-iii" = {
    owner = "nit";
    group = "nginx";
    mode = "0440";
  };

  services.firefly-iii = {
    enable = true;
    user = "nit";
    group = "nginx";
    dataDir = "/var/lib/firefly-iii";
    enableNginx = true;
    virtualHost = "firefly.local";

    poolConfig = {
      "pm" = "ondemand"; # Todo junto, sin guiones
      "pm.max_children" = 2;
      "pm.process_idle_timeout" = "10s";
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
          addr = "127.0.0.1";
          port = 9080;
        }
      ];
    };
  };

  networking.hosts = {
    "127.0.0.1" = ["firefly.local"];
  };
}
