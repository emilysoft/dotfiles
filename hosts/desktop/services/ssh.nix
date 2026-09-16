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
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
}
