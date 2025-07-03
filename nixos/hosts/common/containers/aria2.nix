{ opts, config, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ aria_rpc aria_web ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.downloads}/Aria 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  virtualisation.oci-containers.containers = {
    "aria2" = {
      autoStart = opts.autostart-non-essential-services;
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
        ARIA2RPCPORT = opts.ports.aria_rpc;
        # EMBED_RPC_SECRET = "false";
      };
      environmentFiles = [ config.age.secrets.aria2_env.path ];
      extraOptions = [
        "--add-host=${opts.hostname}:${opts.lanAddress}"
        "--no-healthcheck"
        "--privileged"
      ];
      image = "hurlenko/aria2-ariang:latest";
      ports = [
        "${opts.ports.aria_rpc}:6800"
        "${opts.ports.aria_web}:8080"
      ];
      volumes = [
        "aria2_conf:/aria2/conf"
        "${opts.paths.downloads}/Aria:/aria2/data"
      ];
    };
  };
}
