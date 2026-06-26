{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    nameservers = ["8.8.8.8" "1.1.1.1"];
    hostName = "nixos";
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };

  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  security.polkit.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("networkmanager") &&
          action.id.indexOf("org.freedesktop.NetworkManager.") == 0) {
        return polkit.Result.YES;
      }
    });
  '';
}
