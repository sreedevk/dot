{ pkgs, opts, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ stirling-pdf ]);
  virtualisation.oci-containers.containers = {
    "stirling-pdf" = {
      autoStart = true;
      image = "frooodle/s-pdf:latest";
      extraOptions = [ "--no-healthcheck" ];
      volumes = [
        "stirling_pdf_trainingdata:/usr/share/tessdata"
        "stirling_pdf_configs:/configs"
        "stirling_pdf_logs:/logs"
        "stirling_pdf_customfiles:/customFiles"
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
