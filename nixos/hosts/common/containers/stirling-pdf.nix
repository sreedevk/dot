{ pkgs, opts, secrets, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ stirling-pdf ]);
  virtualisation.oci-containers.containers = {
    "stirling-pdf" = {
      autoStart = true;
      image = "frooodle/s-pdf:latest";
      extraOptions = [ "--no-healthcheck" ];
      volumes = [
        "${opts.paths.application_data}/StirlingPDF/TrainingData:/usr/share/tessdata"
        "${opts.paths.application_data}/StirlingPDF/ExtraConfigs:/configs"
        "${opts.paths.application_data}/StirlingPDF/Logs:/logs"
        "${opts.paths.application_data}/StirlingPDF/CustomFiles:/customFiles"
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
