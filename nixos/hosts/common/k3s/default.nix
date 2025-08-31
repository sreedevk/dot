{ pkgs
, config
, opts
, ...
}:
let
  node_server_opts =
    if opts.hostname == "nullptrderef1" then
      [ ]
    else
      [ "--server https://${opts.hostname}:${opts.ports.k3s-control-plane}" ];
in
{
  ##### FIREWALL ####

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
    with opts.ports;
    [
      k3s-inter-node-net
    ]
  );

  services.k3s = {
    enable = false;
    role = "server";
    clusterInit = opts.hostname == "nullptrderef1";
    extraFlags =
      let
        flags = [
          "--token-file=${config.age.secrets.k3s_token.path}"
          "--write-kubeconfig-mode \"0644\""
          "--cluster-init"
          "--disable=servicelb"
          "--disable=traefik"
          "--disable=local-storage"
          "--cluster-init-namespace=default"
        ];
      in
      flags ++ node_server_opts;
  };
}
