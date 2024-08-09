{ pkgs, opts, secrets, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ podgrab ]);
  virtualisation.oci-containers.containers = {
    podgrab = {
      autoStart = true;
      image = "akhilrex/podgrab";
      extraOptions = [
        "--add-host=nullptrderef1:${opts.lanAddress}"
        "--privileged"
        "--no-healthcheck"
      ];
      ports = [
        "${opts.ports.podgrab}:8080"
      ];
      volumes = [
        "${opts.paths.application_data}/podgrab/config:/config"
        "${opts.paths.application_data}/podgrab/assets:/assets"
      ];
      environment = {
        CHECK_FREQUENCY = "240";
        PASSWORD = "${secrets.podgrab-password}"; # username podgrab
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
