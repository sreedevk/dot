{ pkgs, opts, config, ... }:
{
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      tubearchivist
      tubearchivist-redis
    ]);

  virtualisation.oci-containers.containers = {
    tubearchivist-app = {
      image = "bbilly1/tubearchivist";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [
        "tubearchivist-es"
        "tubearchivist-redis"
      ];
      autoStart = true;
      ports = [ "${opts.ports.tubearchivist}:8000" ];
      volumes = [
        "${opts.paths.videos}/YouTube:/youtube"
        "${opts.paths.application_data}/tubearchivist/cache:/cache"
      ];
      labels = {
        "kuma.tubearchivist.http.name" = "TubeArchivist";
        "kuma.tubearchivist.http.url" = "http://${opts.lanAddress}:${opts.ports.tubearchivist}/health";
      };
      environmentFiles = [ config.age.secrets.tubearchivist_env.path ];
      environment = {
        ES_URL = "http://${opts.hostname}:${opts.ports.tubearchivist-es}";
        REDIS_HOST = "${opts.hostname}";
        TZ = opts.timeZone;
        HOST_UID = opts.adminUID;
        HOST_GID = opts.adminGID;
        TA_HOST = "tube.nullptr.sh";
        TA_USERNAME = "admin";
      };
    };

    tubearchivist-es = {
      autoStart = true;
      image = "bbilly1/tubearchivist-es";
      extraOptions =
        [
          "--add-host=${opts.hostname}:${opts.lanAddress}"
          "--no-healthcheck"
          "--ulimit=memlock=-1:-1"
        ];
      ports = [ "${opts.ports.tubearchivist-es}:9200" ];
      volumes = [
        "${opts.paths.application_data}/tubearchivist/es:/usr/share/elasticsearch/data"
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
      autoStart = true;
      image = "redis/redis-stack-server";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      dependsOn = [
        "tubearchivist-es"
      ];
      ports = [ "${opts.ports.tubearchivist-redis}:6379" ];
      volumes = [
        "${opts.paths.application_data}/tubearchivist/redis:/data"
      ];
    };
  };
}
