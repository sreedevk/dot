{ config, pkgs, opts, ... }: {
  services.adguardhome = {
    enable = true;
    host = "0.0.0.0";
    port = pkgs.lib.strings.toInt opts.ports.adguard_web;
    mutableSettings = false;
    openFirewall = true;
    extraArgs = [ ];
    settings = {
      statistics = {
        interval = "168h";
        enabled = true;
      };
      filters = [
        {
          enabled = true;
          url =
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          name = "StevenBlack's List";
          ID = 1;
        }
        {
          enabled = true;
          url =
            "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt";
          name = "DeveloperDan's Advertisements & Tracking List";
          ID = 15;
        }
        {
          enabled = true;
          url = "https://easylist.to/easylist/easylist.txt";
          name = "EasyList Basic";
          ID = 16;
        }
        {
          enabled = true;
          url = "https://easylist.to/easylist/easyprivacy.txt";
          name = "EasyList Privacy";
          ID = 17;
        }
        {
          enabled = true;
          url = "https://secure.fanboy.co.nz/fanboy-annoyance.txt";
          name = "Fanboy's Annoyances";
          ID = 18;
        }
        {
          enabled = true;
          url = "https://easylist.to/easylist/fanboy-social.txt";
          name = "Fanboy's Social";
          ID = 19;
        }
        {
          enabled = true;
          url = "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt";
          name = "Fanboy's Cookiemonster";
          ID = 20;
        }
        {
          enabled = true;
          url =
            "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.plus.txt";
          name = "Adblock Pro Plus";
          ID = 25;
        }
      ];
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        rewrites = [
          {
            domain = "nullptrderef1";
            answer = "192.168.1.179";
          }
          {
            domain = "nullptrderef1.localhost";
            answer = "192.168.1.179";
          }
          {
            domain = "null.localhost";
            answer = "192.168.1.179";
          }
          {
            domain = "null.arpa";
            answer = "192.168.1.179";
          }
          {
            domain = "rpi4b.localhost";
            answer = "192.168.1.152";
          }
          {
            domain = "devstation.localhost";
            answer = "192.168.1.249";
          }
        ];
      };
      dns = {
        bind_host = "0.0.0.0";
        bootstrap_dns = [ "9.9.9.9" "8.8.8.8" "8.8.4.4" ];
        ratelimit = 200;
        upstream_dns = [
          "https://extended.dns.mullvad.net/dns-query"
          "https://dns10.quad9.net/dns-query"
          "https://dns.cloudflare.com/dns-query"
          "https://adblock.doh.mullvad.net/dns-query"
          "https://dns.nextdns.io"
        ];
        upstream_mode = "load_balance";
      };
    };
  };
}
