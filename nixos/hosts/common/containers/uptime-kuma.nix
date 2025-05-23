{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ uptime-kuma ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/uptime-kuma 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  environment.etc = {
    "autokuma/staticmon/taskchampion.json" = {
      enable = true;
      uid = pkgs.lib.strings.toInt opts.adminUID;
      gid = pkgs.lib.strings.toInt opts.adminGID;
      mode = "0600";
      text = builtins.toJSON {
        name = "Taskchampion Task Server";
        type = "http";
        url = "http://${opts.lanAddress}:${opts.ports.taskchampion}";
        parent_name = "${opts.hostname}";
        group = {
          name = "nullptrderef1";
        };
      };
    };
    "autokuma/staticmon/devtechnica.json" = {
      enable = true;
      uid = pkgs.lib.strings.toInt opts.adminUID;
      gid = pkgs.lib.strings.toInt opts.adminGID;
      mode = "0600";
      text = builtins.toJSON [
        { name = "devtechnica"; type = "group"; }
        {
          name = "www.devtechnica.com";
          type = "http";
          parent_name = "devtechnica[0]";
          url = "https://devtechnica.com";
        }
        {
          name = "www.sree.dev";
          type = "http";
          parent_name = "devtechnica[0]";
          url = "https://sree.dev";
        }
        {
          name = "www.resume.sree.dev";
          type = "http";
          parent_name = "devtechnica[0]";
          url = "https://resume.sree.dev";
        }
      ];
    };
  };

  virtualisation.oci-containers.containers = {
    "uptime-kuma" = {
      autoStart = opts.autostart-non-essential-services;
      image = "louislam/uptime-kuma:latest";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "${opts.paths.app_datafiles}/uptime-kuma:/app/data"
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
      ];
      ports = [ "${opts.ports.uptime-kuma}:3001" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "autokuma" = {
      autoStart = opts.autostart-non-essential-services;
      image = "ghcr.io/bigboot/autokuma:latest";
      dependsOn = [ "uptime-kuma" ];
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      volumes = [
        "/etc/autokuma/staticmon:/staticmon"
        "${opts.paths.podmanSocket}:/var/run/docker.sock"
      ];
      environmentFiles = [ config.age.secrets.autokuma_env.path ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        AUTOKUMA__KUMA__URL = "http://${opts.hostname}:${opts.ports.uptime-kuma}";
        AUTOKUMA__ON_DELETE = "delete";
        AUTOKUMA__DELETE_GRACE_PERIOD = "300";
        AUTOKUMA__STATIC_MONITORS = "/staticmon";
        AUTOKUMA__TAG_NAME = "AutoKuma";
        AUTOKUMA__TAG_COLOR = "#42C0FB";
        AUTOKUMA__MIGRATE = "true";
      };
    };
  };
}
