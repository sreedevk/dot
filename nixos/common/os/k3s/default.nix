{ pkgs
, config
, opts
, ...
}:
{
  imports = [
    ./apps/flaresolverr.nix
  ];

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports;
    [
      k3s-control-plane
      k3s-etcd-clients
      k3s-etcd-peers
    ]
  );

  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ k3s-inter-node-net ]
  );

  services.k3s = {
    enable = false;
    role = "server";
    clusterInit = opts.hostname == "apollo";
    tokenFile = config.age.secrets.k3s_token.path;
    serverAddr = "https://${opts.hostname}:${opts.ports.k3s-control-plane}";
    extraFlags = [
      # "--disable=local-storage"
      "--write-kubeconfig-mode 0644"
      "--cluster-init"
      "--cluster-init-namespace=default"
      "--disable=servicelb"
      "--disable=traefik"
    ];
  };
}
