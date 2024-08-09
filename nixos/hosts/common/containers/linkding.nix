{ config, lib, pkgs, secrets, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ linkding ]);
  virtualisation.oci-containers.containers = {
    "linkding" = {
      autoStart = true;
      image = "sissbruecker/linkding:latest";
      extraOptions =
        [ "--add-host=nullptrderef1:${opts.lanAddress}" "--no-healthcheck" ];
      volumes =
        [ "${opts.paths.application_data}/linkding:/etc/linkding/data" ];
      ports = [ "${opts.ports.linkding}:9090" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };
  };
}
