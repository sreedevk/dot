{ pkgs, opts, config, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [
    bitmagnet-web
    bitmagnet-bittorrent
  ]);

  virtualisation.oci-containers.containers = {
    bitmagnet-app = {
      autoStart = true;
      image = "ghcr.io/bitmagnet-io/bitmagnet:latest";
      dependsOn = [ "bitmagnet-db" ];
      hostname = "bitmagnet";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [
        "${opts.ports.bitmagnet-web}:3333"
        "${opts.ports.bitmagnet-bittorrent}:3334/tcp"
        "${opts.ports.bitmagnet-bittorrent}:3334/udp"
      ];
      environmentFiles = [ config.age.secrets.bitmagnet_env.path ];
      cmd = [ "worker" "run" "--keys=http_server" "--keys=queue_server" "--keys=dht_crawler" ];
    };

    bitmagnet-db = {
      autoStart = true;
      image = "postgres:16-alpine";
      hostname = "bitmagnet_db";
      volumes = [ "bitmagnet_data:/var/lib/postgresql/data" ];
      environmentFiles = [ config.age.secrets.bitmagnet_env.path ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--health-cmd=/usr/bin/pg_isready -U postgres"
        "--health-interval=10s"
        "--health-timeout=30s"
      ];
    };
  };
}
