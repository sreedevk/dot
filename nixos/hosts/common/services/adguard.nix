{ config, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ adguard_dns ]); #  adguard_web
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ adguard_dns ]);

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
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
          name = "Hagezi's Multi Pro (recommended)";
          ID = 1;
        }
        {
          enabled = false;
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.plus.txt";
          name = "Hagezi's Multi Pro++ (aggressive)";
          ID = 2;
        }
        {
          enabled = false;
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/ultimate.txt";
          name = "Hagezi's Multi Ultimate (hardcore)";
          ID = 3;
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/fake.txt";
          name = "Hagezi's Fakesites List";
          ID = 4;
        }
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
        server_name = "adguard.nullptr.sh";
        force_https = false;
        port_https = pkgs.lib.strings.toInt opts.ports.adguard_web_https;
        port_dns_over_tls = 0;
        port_dns_over_quic = 0;
        port_dnscrypt = 0;
        allow_unencrypted_doh = true;
        certificate_chain = "";
        private_key = "";
      };
      dns = {
        bind_host = "0.0.0.0";
        cache_size = 1000000;
        cache_ttl_min = 3600;
        cache_ttl_max = 86400;
        cache_optimistic = true;
        bootstrap_dns = [
          "9.9.9.9"
          "1.1.1.1"
          "1.0.0.1"
        ];
        ratelimit = 500;
        upstream_dns = [
          "https://dns.quad9.net/dns-query"
          "https://dns.cloudflare.com/dns-query"
          "https://adblock.dns.mullvad.net/dns-query"
          "https://dns0.eu"
          "https://freedns.controld.com/p0"
        ];
        upstream_mode = "load_balance";
      };
    };
  };
}
