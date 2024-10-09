{ pkgs, config, opts, ... }:
{
  networking.firewall.allowedTCPPorts =
    builtins.map pkgs.lib.strings.toInt (with opts.ports; [
      grafana
      influxdb
      prometheus_app
      prometheus_node
      promtail
    ]);

  systemd.tmpfiles.rules = [
    "d ${opts.paths.app_datafiles}/prometheus 0755 ${opts.adminUID} ${opts.adminGID} -"
    "f ${opts.paths.app_datafiles}/prometheus/queries.active 0755 ${opts.adminUID} ${opts.adminGID} -"
  ];

  environment.etc = {
    "loki/local.yaml" = {
      enable = true;
      text = ''
        # This is a complete configuration to deploy Loki backed by the filesystem.
        # The index will be shipped to the storage via tsdb-shipper.

        auth_enabled: false

        server:
          http_listen_port: 3100

        common:
          ring:
            instance_addr: 127.0.0.1
            kvstore:
              store: inmemory
          replication_factor: 1
          path_prefix: /tmp/loki

        schema_config:
          configs:
          - from: 2020-05-15
            store: tsdb
            object_store: filesystem
            schema: v13
            index:
              prefix: index_
              period: 24h

        storage_config:
          filesystem:
            directory: /tmp/loki/chunks
      '';
    };
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

        - name: Loki
          type: loki
          access: proxy 
          orgId: 1
          url: http://${opts.hostname}:${opts.ports.loki}
          basicAuth: false
          isDefault: false
          version: 1
          editable: false
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

  services.promtail = {
    enable = true;
    configuration = {
      server = {
        http_listen_port = pkgs.lib.strings.toInt opts.ports.promtail;
        grpc_listen_port = 0;
      };

      clients = [
        { url = "http://${opts.hostname}:${opts.ports.loki}/loki/api/v1/push"; }
      ];

      scrape_configs = [
        {
          job_name = "system";
          journal = {
            path = "/var/log/journal";
            max_age = "12h";
            labels = {
              job = "systemd-journal";
            };
          };
          relabel_configs = [
            {
              source_labels = [ "__journal__systemd_unit" ];
              target_label = "unit";
            }
          ];
        }
      ];
    };
  };

  virtualisation.oci-containers.containers = {
    loki = {
      autoStart = true;
      image = "grafana/loki:3.0.0";
      ports = [ "${opts.ports.loki}:3100" ];
      cmd = [ "-config.file=/etc/loki/local.yaml" ];
      volumes = [ "/etc/loki/local.yaml:/etc/loki/local.yaml:ro" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" "--user=${opts.adminUID}" ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.loki.http.parent_name" = "${opts.hostname}";
        "kuma.loki.http.name" = "Loki";
        "kuma.loki.http.url" = "http://${opts.lanAddress}:${opts.ports.loki}/ready";
      };
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    prometheus = {
      autoStart = true;
      image = "prom/prometheus:latest";
      dependsOn = [ "influxdb" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" "--user=${opts.adminUID}" ];
      ports = [ "${opts.ports.prometheus_app}:9090" ];
      volumes = [
        "/etc/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro"
        "${opts.paths.app_datafiles}/prometheus:/prometheus"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.prometheus.http.parent_name" = "${opts.hostname}";
        "kuma.prometheus.http.name" = "Prometheus";
        "kuma.prometheus.http.url" = "http://${opts.lanAddress}:${opts.ports.prometheus_app}/-/healthy";
      };
      cmd = [ "--config.file=/etc/prometheus/prometheus.yml" ];
      environment = {
        TZ = opts.timeZone;
        PUID = opts.adminUID;
        PGID = opts.adminGID;
      };
    };

    grafana = {
      autoStart = true;
      image = "grafana/grafana:latest";
      dependsOn = [ "influxdb" "loki" "prometheus" ];
      extraOptions =
        [ "--add-host=${opts.hostname}:${opts.lanAddress}" "--no-healthcheck" "--user=${opts.adminUID}" ];
      ports = [ "${opts.ports.grafana}:3000" ];
      volumes = [
        "/etc/grafana/datasource.yml:/etc/grafana/provisioning/datasources/datasource.yml:ro"
        "grafana_db:/var/lib/grafana"
      ];
      labels = {
        "kuma.${opts.hostname}.group.name" = "${opts.hostname}";
        "kuma.grafana.http.parent_name" = "${opts.hostname}";
        "kuma.grafana.http.name" = "Grafana";
        "kuma.grafana.http.url" = "http://${opts.lanAddress}:${opts.ports.grafana}/api/health";
      };
      environment = {
        TZ = opts.timeZone;
      };
    };

    influxdb = {
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
        "influx_db:/var/lib/influxdb2"
        "influx_config:/etc/influxdb2"
        "influx_scripts:/docker-entrypoint-initdb.d"
      ];
      environment = {
        TZ = opts.timeZone;
      };
    };

  };
}
