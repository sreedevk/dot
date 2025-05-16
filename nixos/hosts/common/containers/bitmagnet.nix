{ config, lib, pkgs, opts, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/bitmagnet        0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/bitmagnet/config 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ bitmagnet-app bitmagnet-p2p bitmagnet-db ]);

  networking.firewall.allowedUDPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ bitmagnet-p2p ]);

  virtualisation.oci-containers.containers = {
    "bitmagnet-app" = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/bitmagnet-io/bitmagnet:latest";
      dependsOn = [ "bitmagnet-db" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [
        "${opts.ports.bitmagnet-app}:3333"
        "${opts.ports.bitmagnet-p2p}:3334/tcp"
        "${opts.ports.bitmagnet-p2p}:3334/udp"
      ];
      command = [ "worker" "run" "--keys=http_server" "--keys=queue_server" "--keys=dht_crawler" ];
      volumes = [
        "${opts.paths.app_datafiles}/bitmagnet/config:/root/.config/bitmagnet"
      ];
      environmentFiles = [ config.age.secrets.bitmagnet_env.path ];
      environment = {
        POSTGRES_HOST = opts.hostname;
        POSTGRES_PORT = opts.ports.bitmagnet-db;
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "bitmagnet-db" = {
      autoStart = opts.autostart-non-essential-services;
      image = "postgres:16-alpine";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--shm-size=1G"
        "--health-cmd=pg_isready"
        "--health-timeout=10s"
        "--health-retries=5"
        "--health-start-period=30s"
        "--health-timeout=10s"
      ];
      ports = [ "${opts.ports.bitmagnet-db}:5432" ];
      volumes = [ "bitmagnet_db_data:/var/lib/postgresql/data" ];
      environmentFiles = [ config.age.secrets.bitmagnet_env.path ];
      environment = {
        POSTGRES_DB = "bitmagnet";
      };
    };
  };
}
