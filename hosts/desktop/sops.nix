{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/nit/.config/sops/age/keys.txt";
    secrets = {
      "github/neetoons/ssh_key" = {
        path = "/home/nit/.ssh/id_ed25519";
        owner = "nit";
        mode = "0600";
      };
    };
  };
}
