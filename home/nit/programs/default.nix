{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    inputs.oxicord.packages.${system}.default
    inputs.elyprismlauncher.packages.${system}.default
  ];

  imports = [
    ./communication
    ./desktop-environment
    ./developing
    ./utilities
    ./gaming
    ./media
    ./office
    ./terminal
  ];
}
