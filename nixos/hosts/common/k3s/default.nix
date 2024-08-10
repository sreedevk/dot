{ pkgs, config, opts, ... }:
{
  ##### FIREWALL ####
  networking.firewall.allowedTCPPorts = [
    6443 # API server
    2379 # etcd clients "High Availability Embedded etcd"
    2380 # etcd peers "High Availability Embedded etcd" 
  ];
  networking.firewall.allowedUDPPorts = [
    # 8472 # flannel: multi-node for inter-node networking
  ];

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = toString [
      # "--kubelet-arg=v=4" # Optionally add additional args to k3s
    ];
  };

}
