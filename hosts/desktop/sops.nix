{config, ...}: let
  user = "nit";
in {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.users.users.${user}.home}/.config/sops/age/keys.txt";
  };
}
