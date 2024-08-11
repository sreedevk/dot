{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ linkding-app linkding-db ]);

  virtualisation.oci-containers.containers = {

    "linkding-app" = {
      autoStart = true;
      image = "sissbruecker/linkding:latest";
      dependsOn = [ "linkding-db" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes =
        [ "${opts.paths.application_data}/linkding:/etc/linkding/data" ];
      ports = [ "${opts.ports.linkding-app}:9090" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        LD_DB_ENGINE = "postgres";
        LD_DB_DATABASE = secrets.linkding_db_name;
        LD_DB_USER = secrets.linkding_db_username;
        LD_DB_PASSWORD = secrets.linkding_db_password;
        LD_DB_HOST = secrets.linkding_db_host;
        LD_DB_PORT = opts.ports.linkding-db;
      };
    };

    "linkding-db" = {
      autoStart = true;
      image = "postgres:latest";
      volumes = [ "${opts.paths.application_databases}/linkding:/var/lib/postgresql/data" ];
      ports = [ "${opts.ports.linkding-db}:5432" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        POSTGRES_USER = secrets.linkding_db_username;
        POSTGRES_PASSWORD = secrets.linkding_db_password;
        POSTGRES_DB = secrets.linkding_db_name;
      };
    };

  };
}
