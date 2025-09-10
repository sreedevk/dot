{ pkgs, opts, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ adguard_dns ]
  ); # adguard_web
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ adguard_dns ]
  );

  services.adguardhome = {
    enable = true;
    host = "0.0.0.0";
    port = pkgs.lib.strings.toInt opts.ports.adguard_web;
    mutableSettings = false;
    openFirewall = true;
    extraArgs = [ ];
    settings = {
      auth_attempts = 10;
      block_auth_min = 60;
      web_session_ttl = 24;
      dhcp = {
        enabled = false;
        interface_name = "enp2s0";
        dhcpv4 = {
          gateway_ip = "192.168.1.1";
          subnet_mask = "255.255.255.0";
          range_start = "192.168.1.100";
          range_end = "192.168.1.240";
          lease_duration = 86400;
        };
      };
      users = [
        {
          name = "admin";
          password = "$2a$12$GyN4HZQr7KGL92lihHFDBOQlY3sQ.xjge3TXs70ENlCnQ4OQwgXQG"; # bcrypt hash
        }
      ];
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
      querylog = {
        enabled = true;
        file_enabled = false;
        size_memory = 10000;
        interval = "1h";
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        filters_update_interval = 8;
        blocking_mode = "nxdomain"; # or null_ip (0.0.0.0) or custom_ip (set blocking_ipv4 or blocking_ipv6)
        blocked_response_ttl = 14400;
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
        enabled = false;
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
        bind_hosts = [
          "0.0.0.0"
        ];
        cache_size = 1000000;
        cache_ttl_min = 3600;
        cache_ttl_max = 86400;
        cache_optimistic = true;
        bootstrap_dns = [
          "1.0.0.1"
          "1.1.1.1"
          "149.112.112.10"
          "9.9.9.10"
          "9.9.9.9"
        ];
        ratelimit = 500;
        upstream_dns = [
          "https://dns.cloudflare.com/dns-query"
          "https://dns.google/dns-query"
          "https://dns10.quad9.net/dns-query"
          "https://unfiltered.adguard-dns.com/dns-query"
          "tls://dns10.quad9.net"
        ];
        upstream_mode = "parallel"; # load_balance
        upstream_timeout = "5s";
        use_http3_upstreams = false;
      };
    };
  };
}
