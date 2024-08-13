{ pkgs, config, secrets, opts, ... }:
{
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      grafana
      netdata
      influxdb
      prometheus_app
      prometheus_node
    ]);

  services.prometheus.exporters.node = {
    enable = true;
    port = pkgs.lib.strings.toInt opts.ports.prometheus_node;
    # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/exporters.nix
    enabledCollectors = [ "systemd" ];
    # /nix/store/zgsw0yx18v10xa58psanfabmg95nl2bb-node_exporter-1.8.1/bin/node_exporter  --help
    extraFlags = [ "--collector.ethtool" "--collector.softirqs" "--collector.tcpstat" "--collector.wifi" ];
  };

  services.netdata = {
    enable = true;
    config = {
      global = {
        "update every" = 15;
      };
      ml = {
        "enabled" = "yes";
      };
    };
    configDir = {
      "stream.conf" = pkgs.writeText "stream.conf" ''
        [stream]
          enabled = yes
          destination = ${opts.hostname}:${opts.ports.netdata}
          api key = ${secrets.netdata_api_key}
        [UUID]
          enabled = yes
      '';
    };
  };

  virtualisation.oci-containers.containers = {

    "prometheus" = {
      autoStart = true;
      image = "prom/prometheus";
      dependsOn = [ "influxdb" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" "--user=${opts.adminUID}" ];
      ports = [ "${opts.ports.prometheus_app}:9090" ];
      volumes = [
        "${opts.paths.application_data}/Prometheus/config:/etc/prometheus"
        "${opts.paths.application_data}/Prometheus/data:/prometheus"
      ];
      cmd = [ "--config.file=/etc/prometheus/prometheus.yml" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "grafana" = {
      autoStart = true;
      image = "grafana/grafana";
      dependsOn = [ "influxdb" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" "--user=${opts.adminUID}" ];
      ports = [ "${opts.ports.grafana}:3000" ];
      volumes = [
        "${opts.paths.application_data}/Grafana/config:/etc/grafana/provisioning/datasources"
        "${opts.paths.application_databases}/Grafana:/var/lib/grafana"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    "influxdb" = {
      autoStart = true;
      image = "influxdb:2.7.6-alpine";
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" ];
      ports = [ "${opts.ports.influxdb}:3000" ];
      volumes = [
        "${opts.paths.application_databases}/InfluxDB:/var/lib/influxdb2"
        "${opts.paths.application_data}/InfluxDB/config:/etc/influxdb2"
        "${opts.paths.application_data}/InfluxDB/scripts:/docker-entrypoint-initdb.d"
      ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

  };
}
