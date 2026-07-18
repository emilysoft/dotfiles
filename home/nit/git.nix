{config, ...}: let
  emily = {
    name = "emilysoft";
    email = "aura.git@proton.me";
  };

  neetoons = {
    name = "neetoons";
    email = "neet.toons@gmail.com";
  };
in {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "ghost";
        email = "invalid@void.invalid";
      };
    };

    includes = [
      {
        condition = "gitdir:~/.dotfiles/**";
        contents.user = emily;
      }
      {
        condition = "gitdir:~/Projects/${emily.name}/**";
        contents.user = emily;
      }
      {
        condition = "gitdir:~/Projects/${neetoons.name}/**";
        contents.user = neetoons;
      }
    ];
  };

  sops.secrets = {
    "github/${emily.name}/ssh_key" = {
      path = "/home/nit/.ssh/id_ed25519_${emily.name}";
      mode = "0600";
    };
    "github/${neetoons.name}/ssh_key" = {
      path = "/home/nit/.ssh/id_ed25519_${neetoons.name}";
      mode = "0600";
    };
  };
}
