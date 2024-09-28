{ config, lib, pkgs, opts, ... }: {
  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ actual-app ]);
  virtualisation.oci-containers.containers = {
    actual-app = {
      autoStart = true;
      extraOptions = [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      image = "docker.io/actualbudget/actual-server:latest";
      ports = [ "${opts.ports.actual-app}:5006" ];
      volumes = [ "actual_budget_data:/data" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.actual.http.parent_name" = "${opts.hostname}";
        "kuma.actual.http.name" = "Actual";
        "kuma.actual.http.url" = "http://${opts.lanAddress}:${opts.ports.memos}/";
      };
      environment = {
        PGID = opts.adminGID;
        PUID = opts.adminUID;
        TZ = opts.timeZone;
      };
    };
  };
}
