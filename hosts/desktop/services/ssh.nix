{...}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  programs.ssh = {
    extraConfig = ''
      Host github.com-emilysoft
          HostName github.com
          IdentityFile ~/.ssh/id_ed25519_emilysoft
          IdentitiesOnly yes

      Host codeberg.org-emilysoft
          HostName codeberg.org
          IdentityFile ~/.ssh/id_ed25519_emilysoft
          IdentitiesOnly yes

      Host github.com-neetoons
          HostName github.com
          IdentityFile ~/.ssh/id_ed25519_neetoons
          IdentitiesOnly yes
    '';
  };
  programs.gnupg.agent = {
    enableSSHSupport = false;
  };

  networking.firewall.allowedTCPPorts = [22];
}
