{ pkgs, config, opts, ... }:
{
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      grafana
      influxdb
      prometheus_app
      prometheus_node
    ]);

  environment.etc = {

    "grafana/datasource.yml" = {
      enable = true;
      text = ''
        apiVersion: 1

        datasources:
        - name: Prometheus
          type: prometheus
          url: http://${opts.hostname}:${opts.ports.prometheus_app}
          isDefault: true
          access: proxy
          editable: true
      '';
    };

    "prometheus/prometheus.yml" = {
      enable = true;
      text = ''
        global:
          scrape_interval: 15s
          scrape_timeout: 10s
          evaluation_interval: 15s
        alerting:
          alertmanagers:
          - static_configs:
            - targets: []
            scheme: http
            timeout: 10s
            api_version: v1
        scrape_configs:
        - job_name: prometheus
          honor_timestamps: true
          scrape_interval: 15s
          scrape_timeout: 10s
          metrics_path: /metrics
          scheme: http
          static_configs:
          - targets:
            - localhost:9090
        - job_name: node_exporter
          static_configs:
            - targets:
              - ${opts.hostname}:${opts.ports.prometheus_node}
      '';
    };
  };

  services.prometheus.exporters.node = {
    enable = true;
    port = pkgs.lib.strings.toInt opts.ports.prometheus_node;
    # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/exporters.nix
    enabledCollectors = [ "systemd" ];
    # /nix/store/zgsw0yx18v10xa58psanfabmg95nl2bb-node_exporter-1.8.1/bin/node_exporter  --help
    extraFlags = [
      "--collector.ethtool"
      "--collector.softirqs"
      "--collector.tcpstat"
      "--collector.wifi"
      "--collector.zfs"
      "--collector.processes"
      "--collector.filesystem"
    ];
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
        "/etc/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro"
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
        "/etc/grafana/datasource.yml:/etc/grafana/provisioning/datasources/datasource.yml:ro"
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
      ports = [ "${opts.ports.influxdb}:8086" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.influxdb.http.parent_name" = "${opts.hostname}";
        "kuma.influxdb.http.name" = "InfluxDB";
        "kuma.influxdb.http.url" = "http://${opts.lanAddress}:${opts.ports.influxdb}/health";
      };
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
