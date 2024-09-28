{ pkgs, config, opts, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ jellystat-db jellystat-app ]);
  virtualisation.oci-containers.containers = {
    "jellystat-app" = {
      autoStart = true;
      image = "cyfershepard/jellystat:latest";
      dependsOn = [ "jellyfin" "jellystat-db" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.jellystat-app}:3000" ];
      volumes = [
        "jellystat_backups:/app/backend/backup-data"
      ];
      environmentFiles = [ config.age.secrets.jellystat_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        POSTGRES_PORT = opts.ports.jellystat-db;
        POSTGRES_IP = opts.hostname;
      };
    };

    "jellystat-db" = {
      autoStart = true;
      image = "postgres:15.2";
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.jellystat-db}:5432" ];
      volumes = [ "jellystat_db:/var/lib/postgresql/data" ];
      environmentFiles = [ config.age.secrets.jellystat_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
