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
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.plus.txt";
          name = "HaGeZi's Pro++ DNS Blocklist";
          ID = 1;
        }
        {
          enabled = false;
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/tif.txt";
          name = "HaGeZi's Threat Intelligence Feeds DNS Blocklist";
          ID = 2;
        }
        {
          enabled = true;
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/fake.txt";
          name = "HaGeZi's Fake DNS Blocklist";
          id = 3;
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
        cache_size = 1000000;
        cache_ttl_min = 3600;
        cache_ttl_max = 86400;
        cache_optimistic = true;
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
