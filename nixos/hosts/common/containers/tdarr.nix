{ pkgs, config, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ tdarr-node tdarr-server tdarr-web ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/tdarr/server 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/tdarr/configs 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/tdarr/logs 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/tdarr/transcode-cache 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    tdarr-server = {
      autoStart = true;
      image = "haveagitgat/tdarr:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
        "--log-opt=max-size=10m"
        "--log-opt=max-file=5"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/tdarr/server:/app/server"
        "${opts.paths.app_datafiles}/tdarr/configs:/app/configs"
        "${opts.paths.app_datafiles}/tdarr/logs:/app/logs"
        "${opts.paths.media}:/media"
        "${opts.paths.app_datafiles}/tdarr/transcode-cache:/temp"
      ];
      ports = [
        "${opts.ports.tdarr-server}:8266"
        "${opts.ports.tdarr-web}:8265"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        serverIP = "0.0.0.0";
        serverPort = "8266";
        webUIPort = "8265";
        internalNode = "true";
        inContainer = "true";
        ffmpegVersion = "6";
        nodeName = "tdarr-${opts.hostname}-server";
      };
    };
    tdarr-node = {
      autoStart = true;
      dependsOn = [ "tdarr-server" ];
      image = "haveagitgat/tdarr_node:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
        "--log-opt=max-size=10m"
        "--log-opt=max-file=5"
      ];
      volumes = [
        "${opts.paths.app_datafiles}/tdarr/configs:/app/configs"
        "${opts.paths.app_datafiles}/tdarr/logs:/app/logs"
        "${opts.paths.media}:/media"
        "${opts.paths.app_datafiles}/tdarr/transcode-cache:/temp"
      ];
      ports = [ "${opts.ports.tdarr-node}:8268" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        nodeName = "tdarr-${opts.hostname}-node";
        serverIP = opts.lanAddress;
        serverPort = "8266";
        inContainer = "true";
        ffmpegVersion = "6";
      };
    };
  };
}
