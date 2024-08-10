{ opts, secrets, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ aria_rpc aria_web ]);
  virtualisation.oci-containers.containers = {
    "aria2" = {
      autoStart = true;
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
        RPC_SECRET = secrets.aria2_password;
      };
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
        "--privileged"
      ];
      image = "hurlenko/aria2-ariang";
      ports = [
        "${opts.ports.aria_rpc}:6800"
        "${opts.ports.aria_web}:8080"
      ];
      volumes = [
        "${opts.paths.application_data}/aria2:/aria2/conf"
        "${opts.paths.downloads}/Aria2:/aria2/data"
      ];
    };
  };
}
