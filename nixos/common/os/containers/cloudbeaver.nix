{ pkgs
, opts
, ...
}:
{
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
    with opts.ports; [ cloudbeaver ]
  );
  virtualisation.oci-containers.containers = {
    "cloudbeaver" = {
      autoStart = opts.autostart-non-essential-services;
      image = "dbeaver/cloudbeaver:latest";
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
      ];
      ports = [ "${opts.ports.cloudbeaver}:8978" ];
      volumes = [
        "cloudbeaver_data:/opt/cloudbeaver/workspace"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };

}
