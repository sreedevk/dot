{ config, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ unbound_dns ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ unbound_dns ]);

  # TODO: reconfigure unbound to work with adguard
  services.unbound = {
    enable = false;
    settings = {
      server = {
        interface = "127.0.0.1";
        port = pkgs.lib.strings.toInt opts.ports.unbound_dns;
        do-ip4 = "yes";
        do-udp = "yes";
        do-tcp = "yes";
        do-ip6 = "no";
        prefer-ip6 = "no";
      };
      forward-zone = [
        {
          name = ".";
          forward-addr = "1.1.1.1@853#cloudflare-dns.com";
        }
      ];
      remote-control.control-enable = true;
    };
  };

}
