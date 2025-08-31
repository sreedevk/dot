{ pkgs
, opts
, config
, ...
}:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports;
    [
      tubearchivist
      tubearchivist-redis
    ]
  );

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/tubearchivist/cache 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/tubearchivist/es 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/tubearchivist/redis 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    tubearchivist-app = {
      image = "bbilly1/tubearchivist:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [
        "tubearchivist-es"
        "tubearchivist-redis"
      ];
      autoStart = opts.autostart-non-essential-services;
      ports = [ "${opts.ports.tubearchivist}:8000" ];
      volumes = [
        "${opts.paths.videos}/YouTube:/youtube"
        "${opts.paths.app_datafiles}/tubearchivist/cache:/cache"
      ];
      environmentFiles = [ config.age.secrets.tubearchivist_env.path ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.tubearchivist.http.parent_name" = "${opts.hostname}";
        "kuma.tubearchivist.http.name" = "TubeArchivist";
        "kuma.tubearchivist.http.url" = "http://${opts.lanAddress}:${opts.ports.tubearchivist}";
      };
      environment = {
        ES_URL = "http://${opts.hostname}:${opts.ports.tubearchivist-es}";
        REDIS_CON = "redis://${opts.hostname}:${opts.ports.tubearchivist-redis}";
        TZ = opts.timeZone;
        HOST_UID = opts.adminUID;
        HOST_GID = opts.adminGID;
        TA_HOST = "https://tube.nullptr.sh";
        TA_USERNAME = "admin";
      };
    };

    tubearchivist-es = {
      autoStart = opts.autostart-non-essential-services;
      image = "bbilly1/tubearchivist-es:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
        "--ulimit=memlock=-1:-1"
      ];
      ports = [ "${opts.ports.tubearchivist-es}:9200" ];
      volumes = [
        "${opts.paths.app_datafiles}/tubearchivist/es:/usr/share/elasticsearch/data"
      ];
      environmentFiles = [ config.age.secrets.tubearchivist_env.path ];
      environment = {
        ES_JAVA_OPTS = "-Xms512m -Xmx512m";
        "xpack.security.enabled" = "true";
        "discovery.type" = " single-node";
        "path.repo" = "/usr/share/elasticsearch/data/snapshot";
      };
    };

    tubearchivist-redis = {
      autoStart = opts.autostart-non-essential-services;
      image = "redis/redis-stack-server:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      dependsOn = [
        "tubearchivist-es"
      ];
      ports = [ "${opts.ports.tubearchivist-redis}:6379" ];
      volumes = [
        "${opts.paths.app_datafiles}/tubearchivist/redis:/data"
      ];
    };
  };
}
