{ config, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ adguard_dns adguard_web adguard_tls ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ adguard_dns adguard_tls ]);
  services.adguardhome = {
    enable = true;
    host = "0.0.0.0";
    port = pkgs.lib.strings.toInt opts.ports.adguard_web;
    mutableSettings = false;
    openFirewall = true;
    extraArgs = [ ];
    settings = {
      statistics = {
        interval = "48h";
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
          enabled = true;
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
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/ph00lt0/blocklists/master/blocklist.txt";
          name = "ph00lt0 Blocklist";
          id = 4;
        }
        {
          enabled = true;
          url = "https://blocklistproject.github.io/Lists/adguard/ads-ags.txt";
          name = "blocklist-project-ads";
          id = 5;
        }
        {
          enabled = true;
          url = "https://blocklistproject.github.io/Lists/adguard/crypto-ags.txt";
          name = "blocklist-project-crypto";
          id = 6;
        }
        {
          enabled = false;
          url = "https://blocklistproject.github.io/Lists/adguard/facebook-ags.txt";
          name = "blocklist-project-facebook";
          id = 7;
        }
        {
          enabled = true;
          url = "https://blocklistproject.github.io/Lists/adguard/fraud-ags.txt";
          name = "blocklist-project-fraud";
          id = 8;
        }
        {
          enabled = true;
          url = "https://blocklistproject.github.io/Lists/adguard/tiktok-ags.txt";
          name = "blocklist-project-tiktok";
          id = 9;
        }
        {
          enabled = true;
          url = "https://blocklistproject.github.io/Lists/adguard/tracking-ags.txt";
          name = "blocklist-project-tracking";
          id = 10;
        }
      ];
      user_rules = [
        "@@||amazonaws.com"
        "@@||yahoo.com"
        "@@||a2z.com^$important"
        "@@||airbrake.io^$important"
        "@@||audioboom.com^$important"
        "@@||aws.dev^$important"
        "@@||blog.codinghorror.com^$important"
        "@@||buffer.com^$important"
        "@@||download.nvidia.com^$important"
        "@@||feeds.hanselman.com^$important"
        "@@||gitbutler.com^$important"
        "@@||bitbucket.io^$important"
        "@@||one.newrelic.com^$important"
        "@@||portainer.io^$important"
        "@@||torlock.com^$important"
        "||weather-analytics-events.apple.com^$important"
        "||ads.yahoo.com^$important"
        "||geo.yahoo.com^$important"
        "||udc.yahoo.com^$important"
        "||udcm.yahoo.com^$important"
        "||analytics.query.yahoo.com^$important"
        "||analytics.yahoo.com^$important"
        "||partnerads.ysm.yahoo.com^$important"
        "||log.fc.yahoo.com^$important"
        "||gemini.yahoo.com^$important"
        "||adtech.yahooinc.com^$important"
        "||adtago.s3.amazonaws.com^$important"
        "||analyticsengine.s3.amazonaws.com^$important"
        "||analytics.s3.amazonaws.com^$important"
        "||advice-ads.s3.amazonaws.com^$important"
      ];
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        filters_update_interval = 8;
        rewrites = [
          {
            domain = "nullptr.sh";
            answer = "100.117.8.42";
          }
          {
            domain = opts.hostname;
            answer = opts.lanAddress;
          }
          {
            domain = "${opts.hostname}.internal";
            answer = opts.lanAddress;
          }
        ];
      };
      tls = {
        enabled = true;
        server_name = opts.hostname;
        port_https = pkgs.lib.strings.toInt opts.ports.adguard_tls;
      };
      dns = {
        bind_host = "0.0.0.0";
        cache_size = 1000000;
        cache_ttl_min = 3600;
        cache_ttl_max = 86400;
        cache_optimistic = true;
        bootstrap_dns = [ "9.9.9.9" "1.1.1.1" "1.0.0.1" ];
        trusted_proxies = [ opts.lanAddress ];
        ratelimit = 500;
        upstream_dns = [
          "https://dns.cloudflare.com/dns-query"
          "https://dns.google/dns-query"
          "https://dns.quad9.net/dns-query"
          "https://adblock.dns.mullvad.net/dns-query"
        ];
        upstream_mode = "load_balance";
      };
    };
  };
}
