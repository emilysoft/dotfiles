{pkgs, ...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        autoFetch = true;
      };
      refresher = {
        fetchInterval = 0;
      };
    };
  };
}
