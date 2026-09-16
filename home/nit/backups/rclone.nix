{
  pkgs,
  config,
  ...
}: {
  sops.secrets = {
    "rclone" = {
      path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
      mode = "0600";
    };
  };
}
