{config, ...}: {
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
    settings = {
      APP_ENV = "local";
      APP_KEY_FILE = config.sops.secrets."firefly-iii".path;
      SITE_OWNER = "mail@example.com";
      DB_CONNECTION = "sqlite";
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

  systemd.tmpfiles.rules = [
    "d /var/lib/firefly-iii 770 nit nginx -"
  ];
}
