{pkgs, ...}: let
  sanitize-url = pkgs.writeScriptBin "sanitize-url" ''
    #!${pkgs.python3}/bin/python3
    import sys
    import subprocess
    from urllib.parse import urlparse, parse_qs, urlencode, urlunparse

    TRACKING_PARAMS = {
        # Parámetros generales y analítica
        "utm_source", "utm_medium", "utm_campaign", "utm_term", "utm_content",
        "fbclid", "gclid", "msclkid", "mc_eid", "ref", "ref_src",
        # Meta / Instagram / TikTok / X
        "si", "igsh", "ig_rid", "stkn", "share_id", "s", "t"
    }

    def clean_url(url_str):
        url_str = url_str.strip()
        if not (url_str.startswith("http://") or url_str.startswith("https://")):
            return None

        try:
            parsed = urlparse(url_str)
            query_params = parse_qs(parsed.query, keep_blank_values=True)

            cleaned_params = {
                k: v for k, v in query_params.items()
                if k.lower() not in TRACKING_PARAMS
            }

            if len(cleaned_params) == len(query_params):
                return None

            new_query = urlencode(cleaned_params, doseq=True)
            return urlunparse((
                parsed.scheme,
                parsed.netloc,
                parsed.path,
                parsed.params,
                new_query,
                parsed.fragment
            ))
        except Exception:
            return None

    if __name__ == "__main__":
        try:
            # Leer buffer crudo e ignorar bytes no UTF-8 válidos
            raw_bytes = sys.stdin.buffer.read()
            content = raw_bytes.decode("utf-8", errors="ignore")
            cleaned = clean_url(content)

            if cleaned and cleaned != content.strip():
                subprocess.run(
                    ["${pkgs.wl-clipboard}/bin/wl-copy"],
                    input=cleaned.encode("utf-8"),
                    check=True
                )
        except Exception:
            pass
  '';
in {
  environment.systemPackages = [pkgs.wl-clipboard sanitize-url];

  systemd.user.services.url-sanitizer = {
    description = "Sanitizador automático de URLs en el portapapeles";
    wantedBy = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text/plain --watch ${sanitize-url}/bin/sanitize-url";
      Restart = "always";
    };
  };
}
