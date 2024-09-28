{ config, lib, pkgs, opts, ... }: {

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ linkding-app linkding-db ]);
  virtualisation.oci-containers.containers = {

    "linkding-app" = {
      autoStart = true;
      image = "sissbruecker/linkding:latest";
      dependsOn = [ "linkding-db" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes =
        [ "linkding_app:/etc/linkding/data" ];
      ports = [ "${opts.ports.linkding-app}:9090" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.linkding.http.parent_name" = "${opts.hostname}";
        "kuma.linkding.http.name" = "Linkding";
        "kuma.linkding.http.url" = "http://${opts.lanAddress}:${opts.ports.linkding-app}/health";
      };
      environmentFiles = [ config.age.secrets.linkding_env.path ];
      environment = {
        LD_DB_PORT = opts.ports.linkding-db;
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "linkding-db" = {
      autoStart = true;
      image = "postgres:16.4";
      volumes = [ "linkding_db:/var/lib/postgresql/data" ];
      ports = [ "${opts.ports.linkding-db}:5432" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      environmentFiles = [ config.age.secrets.linkding_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

  };
}
