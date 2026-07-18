{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.mis-modulos.profile-principal.enable;
in {
  config = lib.mkIf enabled {
    programs.nixcord = {
      enable = true;
      vesktop.enable = true;
      discord.silenceNoModClientWarning = true;

      #quickCss = "/* css goes here */";
      config = {
        useQuickCss = true;
        themeLinks = [
          "https://catppuccin.github.io/discord/dist/catppuccin-mocha-pink.theme.css"
        ];
        frameless = true;

        plugins = lib.genAttrs [
          "messageLogger"
          "typingIndicator"
          "silentTyping"
          "serverInfo"
          "fakeNitro"
          "noBlockedMessages"
          "voiceMessages"
        ] (name: {enable = true;});
      };
    };
  };
}
