{...}: {
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      Host *
          IdentitiesOnly yes

      Host github.com-emilysoft
          HostName github.com
          IdentityFile ~/.ssh/id_ed25519_emilysoft

      Host codeberg.org-emilysoft
          HostName codeberg.org
          IdentityFile ~/.ssh/id_ed25519_emilysoft

      Host github.com-neetoons
          HostName github.com
          IdentityFile ~/.ssh/id_ed25519_neetoons
    '';
  };

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;
}
