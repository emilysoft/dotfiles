{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.vscbot.nixosModules.default
    inputs.sops-nix.nixosModules.sops
    ./hardware-configuration.nix
    ./sops.nix
    ./modules/greetd.nix
    ./modules/wayland.nix
    ./modules/audio.nix
    ./modules/disk.nix
    ./modules/fonts.nix
    ./modules/file-manager.nix
    ./modules/networking.nix
    ./modules/virtualisation.nix
    ./modules/services/services.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nit = {
    isNormalUser = true;
    description = "Nit's Desktop";
    extraGroups = ["networkmanager" "wheel" "video" "render"];
    shell = pkgs.fish;
  };

  users.users.discord-bot = {
    isSystemUser = true;
    group = "users";
    home = "/var/lib/discord-bots";
  };

  programs = {
    fish.enable = true;
    gamemode.enable = true;
    localsend.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      enableSSHSupport = false;
    };
  };

  networking.firewall.allowedTCPPorts = [22]; # ssh server

  # discord bots depedencies
  environment.systemPackages = with pkgs; [
    pnpm
    nodejs_latest
    typescript
    gcc
  ];

  documentation.man.cache.enable = false;
  security.rtkit.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root"];

  time.timeZone = "America/Caracas";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_VE.UTF-8";
    LC_IDENTIFICATION = "es_VE.UTF-8";
    LC_MEASUREMENT = "es_VE.UTF-8";
    LC_MONETARY = "es_VE.UTF-8";
    LC_NAME = "es_VE.UTF-8";
    LC_NUMERIC = "es_VE.UTF-8";
    LC_PAPER = "es_VE.UTF-8";
    LC_TELEPHONE = "es_VE.UTF-8";
    LC_TIME = "es_VE.UTF-8";
  };

  system.stateVersion = "24.05";
}
