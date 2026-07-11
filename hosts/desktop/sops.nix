{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/nit/.config/sops/age/keys.txt";
    secrets = {
      "github/rate_limit" = {
        neededForUsers = true;
      };
    };
  };
}
