{pkgs, ...}: {
  programs.newsboat = {
    enable = true;
    urls = [
      {url = "https://www.reddit.com/r/NixOS.rss";}
      {url = "https://efectococuyo.com/feed";}
      {url = "https://elpitazo.net/feed";}
      {url = "https://computerhoy.20minutos.es/rss/software";}
      {url = "https://www.elchiguirebipolar.net/feed";}
      {url = "https://armando.info/feed";}
      {url = "https://www.genbeta.com/feedburner.xml";}
      {url = "https://elestimulo.com/feed";}
      {url = "https://caraotadigital.net/feed";}
      {url = "https://uhnplus.com/feed/";}
      {url = "https://www.reddit.com/r/unixporn.rss";}
      {url = "https://es.cointelegraph.com/rss/";}
      {url = "https://www.criptonoticias.com/feed";}
      {url = "https://techcrunch.com/feed/";}
      {url = "http://localhost:8082/feed/category/economia/economia-nacional";}
      {url = "http://localhost:8082/feed/category/banca";}
      {url = "http://localhost:8082/feed/category/finanzas";}
      {url = "https://elestimulo.com/category/terremoto-en-venezuela/feed";}
      {url = "https://elestimulo.com/category/nota-de-prensa/feed";}
      {url = "https://www.tarreo.com/feed/";}
    ];

    extraConfig = ''
      bind k everywhere up
      bind j everywhere down
      bind-key l open feedlist
      bind-key l open articlelist
      bind-key l open article
      bind-key h quit article
      bind-key h quit articlelist

      color listnormal         color15 default
      color listnormal_unread  color2  default
      color listfocus_unread   color2  color0
      color listfocus          default color0
      color background         default default
      color article            default default
      color end-of-text-marker color8  default
      color info               color4  color8
      color hint-separator     default color8
      color hint-description   default color8
      color title              color14 color8

      highlight article "^(Feed|Title|Author|Link|Date): .+" color4 default bold
      highlight article "^(Feed|Title|Author|Link|Date):" color14 default bold

      highlight article "\\((link|image|video)\\)" color8 default
      highlight article "https?://[^ ]+" color4 default
      highlight article "\[[0-9]+\]" color6 default bold
    '';
  };
}
#browser "xdg-open %u"

