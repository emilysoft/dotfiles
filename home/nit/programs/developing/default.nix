{pkgs, ...}: {
  imports = [
    ./nvim.nix
  ];

  home.packages = with pkgs; [
    gemini-cli
    yarn
    pnpm
    nodejs_latest
    typescript
    python310
    bruno # probar APIs
    sqlitebrowser
  ];
}
