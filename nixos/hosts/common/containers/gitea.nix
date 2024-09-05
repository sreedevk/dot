{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ gitea_db gitea_http gitea_ssh ]);
  networking.firewall.allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ gitea_ssh ]);

  virtualisation.oci-containers.containers = {
    "gitea-app" = {
      autoStart = true;
      dependsOn = [ "gitea-db" ];
      image = "gitea/gitea:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      environmentFiles = [ config.age.secrets.gitea_env.path ];
      environment = {
        TZ = opts.timeZone;
        USER_UID = opts.adminUID;
        USER_GID = opts.adminGID;
        GITEA__database__DB_TYPE = "mysql";
        GITEA__database__HOST = "${opts.hostname}:${opts.ports.gitea_db}";
      };
      volumes = [
        "${opts.paths.application_data}/gitea:/data"
      ];
      labels = {
        "kuma.gitea.http.name" = "Gitea";
        "kuma.gitea.http.url" = "http://${opts.lanAddress}:${opts.ports.gitea_http}/api/v1/version";
      };
      ports = [
        "${opts.ports.gitea_http}:3000"
        "${opts.ports.gitea_ssh}:22"
      ];
    };
    "gitea-db" = {
      autoStart = true;
      image = "mariadb:lts";
      ports = [ "${opts.ports.gitea_db}:3306" ];
      cmd = [ "--max-connections=512" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [ "${opts.paths.application_databases}/gitea:/var/lib/mysql" ];
      environmentFiles = [ config.age.secrets.gitea_env.path ];
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
