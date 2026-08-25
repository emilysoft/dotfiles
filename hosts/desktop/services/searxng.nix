{
  pkgs,
  config,
  ...
}: {
  sops.secrets."searxng" = {
    owner = "searx";
    group = "searx";
  };

  services.searx = {
    enable = true;
    package = pkgs.searxng;
    environmentFile = config.sops.secrets."searxng".path;
    settings = {
      server = {
        port = 8080;
        bind_address = "127.0.0.1";
        secret_key = "@SEARXNG_SECRET@";
      };
      general = {
        debug = false;
        instance_name = "SearXNG Instancia Local";
      };
      search = {
        safe_search = 0; # 0: Apagado, 1: Moderado, 2: Estricto
        autocomplete = "duckduckgo";
      };
    };
  };
}
