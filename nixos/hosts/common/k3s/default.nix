{ pkgs, config, secrets, opts, ... }:
{
  ##### FIREWALL ####

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      k3s-control-plane
      k3s-etcd-clients
      k3s-etcd-peers
    ]);

  networking.firewall.allowedUDPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      k3s-inter-node-net
    ]);

  services.k3s = {
    enable = false;
    role = "server";
    token = secrets.k3s-token;
    clusterInit = (opts.hostname == "nullptrderef1");
    extraFlags = toString ([
      "--write-kubeconfig-mode \"0644\""
      "--cluster-init"
      "--disable servicelb"
      "--disable traefik"
      "--disable local-storage"
    ] ++ (if opts.hostname == "nullptrderef1" then [ ] else [ "--server https://${opts.hostname}:${opts.ports.k3s-control-plane}" ]));
  };
}
