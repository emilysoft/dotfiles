{pkgs, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  services = {
    resolved.enable = true;
    tailscale.enable = true;
    cloudflare-warp.enable = true;
  };

  systemd.services.cloudflare-warp = {
    after = ["tailscaled.service" "resolved.service"];
    wants = ["tailscaled.service" "resolved.service"];

    serviceConfig = {
      ExecStartPost = pkgs.writeShellScript "warp-exclude-tailscale" ''
        sleep 2
        ${pkgs.cloudflare-warp}/bin/warp-cli split-tunnel add 100.64.0.0/10 || true
      '';
    };
  };
}
