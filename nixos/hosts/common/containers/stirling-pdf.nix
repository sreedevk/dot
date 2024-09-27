{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ stirling-pdf ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/StirlingPDF/TrainingData 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/StirlingPDF/ExtraConfigs 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/StirlingPDF/Logs 0755 ${opts.adminUID} ${opts.adminGID} -"
    "d ${opts.paths.app_datafiles}/StirlingPDF/CustomFiles 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "stirling-pdf" = {
      autoStart = true;
      image = "frooodle/s-pdf:latest";
      extraOptions = [ "--no-healthcheck" ];
      volumes = [
        "${opts.paths.app_datafiles}/StirlingPDF/TrainingData:/usr/share/tessdata"
        "${opts.paths.app_datafiles}/StirlingPDF/ExtraConfigs:/configs"
        "${opts.paths.app_datafiles}/StirlingPDF/Logs:/logs"
        "${opts.paths.app_datafiles}/StirlingPDF/CustomFiles:/customFiles"
      ];
      ports = [ "${opts.ports.stirling-pdf}:8080" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
        DOCKER_ENABLE_SECURITY = "false";
        INSTALL_BOOK_AND_ADVANCED_HTML_OPS = "false";
        LANGS = "en_US";
      };
    };
  };
}
