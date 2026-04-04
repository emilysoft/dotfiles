{
  programs.nixcord = {
    enable = true;

    vesktop.enable = true;

    #quickCss = "/* css goes here */";
    config = {
      useQuickCss = true;
      themeLinks = [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha-pink.theme.css"
      ];
      frameless = true;

      plugins = {
        messageLogger.enable = true;
        typingIndicator.enable = true;
        silentTyping.enable = true;
        serverInfo.enable = true;
        fakeNitro.enable = true;
        noBlockedMessages.enable = true;
      };
    };
  };
}
