{ pkgs, opts, config, ... }:
let
  copypartyConfig = builtins.path {
    name = "copyparty-config";
    path = ../configurations/copyparty;
  };
in
{

  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ copyparty ]);

  networking.firewall.allowedUDPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [ copyparty ]);

  virtualisation.oci-containers.containers = {
    copyparty = {
      image = "copyparty/ac:latest";
      user = "${opts.adminUID}:${opts.adminGID}";
      ports = [ "${opts.ports.copyparty}:3923" ];
      volumes = [
        "${copypartyConfig}:/cfg:z"
        "${opts.paths.datapool_root}:/w/dpool0:z"
        "${opts.paths.downloads}:/w/downloads:z"
        "${opts.paths.app_datafiles}:/w/appdata:z"
      ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--health-cmd=wget --spider -q 127.0.0.1:3923/?reset=/._"
        "--health-interval=1m"
        "--health-timeout=2s"
        "--health-retries=5"
        "--health-start-period=15s"
      ];
      environment = {
        LD_PRELOAD = "/usr/lib/libmimalloc-secure.so.2";
        PYTHONUNBUFFERED = "1";
        TZ = opts.timeZone;
      };
    };
  };
}
