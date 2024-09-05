{ pkgs, config, opts, ... }:
{

  networking.firewall.allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [
    watch-your-lan
  ]);

  virtualisation.oci-containers.containers = {
    "watchyourlan" = {
      autoStart = true;
      image = "aceberg/watchyourlan:v2";
      extraOptions = [ "--network=host" "--no-healthcheck" "--privileged" ];
      volumes = [ "${opts.paths.application_data}/WatchYourLan:/data/WatchYourLAN" ];
      labels = {
        "kuma.wyl.http.name" = "Watch Your LAN";
        "kuma.wyl.http.url" = "http://${opts.lanAddress}:${opts.ports.watch-your-lan}/api/all";
      };
      environmentFiles = [ config.age.secrets.wyl_env.path ];
      environment = {
        TZ = opts.timeZone;
        IFACES = "enp2s0";
        HOST = "0.0.0.0";
        PORT = opts.ports.watch-your-lan;
        INFLUX_ENABLE = "true";
        INFLUX_SKIP_TLS = "true";
        INFLUX_ADDR = "http://${opts.hostname}:${opts.ports.influxdb}";
        INFLUX_BUCKET = "WYL";
        INFLUX_ORG = opts.hostname;
      };
    };
  };
}
