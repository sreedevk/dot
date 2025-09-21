{ pkgs, opts, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ unbound_dns ]
  );
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ unbound_dns ]
  );

  services.unbound = {
    enable = true;
    checkconf = false;
    settings = {
      server = {
        interface = opts.lanAddress;
        port = pkgs.lib.strings.toInt opts.ports.unbound_dns;
        access-control = [
          "${opts.lanAddress} allow"
          "${opts.addresses.tailscale."${opts.hostname}"} allow"
        ];
        do-ip4 = "yes";
        do-udp = "yes";
        do-tcp = "yes";
        do-ip6 = "no";
        harden-glue = true;
        harden-dnssec-stripped = true;
        use-caps-for-id = false;
        prefetch = true;
        edns-buffer-size = 1232;
        prefer-ip6 = "no";
        hide-identity = true;
        hide-version = true;
      };
      forward-zone = [
        {
          name = ".";
          forward-addr = [
            "9.9.9.9#dns.quad9.net"
            "149.112.112.112#dns.quad9.net"
          ];
          forward-tls-upstream = true;
        }
      ];
      remote-control.control-enable = false;
    };
  };

}
