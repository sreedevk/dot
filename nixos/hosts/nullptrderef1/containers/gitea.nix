{ config, lib, pkgs, secrets, opts, ... }: {
  virtualisation.oci-containers.containers = {
    "gitea-app" = {
      autoStart = true;
      image = "gitea/gitea:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
      volumes = [
        "${opts.paths.application_data}/gitea:/data"
      ];
      ports = [
        "${opts.ports.gitea_http}:3000"
        "${opts.ports.gitea_ssh}:22"
      ];
    };
  };

  "gitea-db" = {
    autoStart = true;
    image = "mariadb:lts";
    ports = [ "${opts.ports.gitea_db}:3306" ];
    cmd = [ "--max-connections=512" ];
    extraOptions = [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
    volumes = [ "${opts.paths.application_databases}/gitea:/var/lib/mysql" ];
    environment = {
      MARIADB_ROOT_PASSWORD = secrets.gitea_database_password;
      MYSQL_DATABASE = secrets.gitea_database_name;
      MYSQL_PASSWORD = secrets.gitea_database_password;
      MYSQL_USER = secrets.gitea_database_username;
      PGID = opts.adminGID;
      PUID = opts.adminUID;
      TZ = opts.timeZone;
    };
  };
}
