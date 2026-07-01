{
  config,
  pkgs,
  opts,
  ...
}:
{

  home.packages = with pkgs; [
    evolution-data-server
    matugen
    roboto
  ];

  programs.noctalia = {
    enable = true;
    package = config.lib.pamShim.replacePam pkgs.noctalia;
    systemd.enable = false;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      wallpaper = {
        enabled = true;
        default.path = "${opts.directories.wallpapers}/${opts.desktop.wallpaper}";
      };
      location = {
        auto_locate = true;
      };
      weather = {
        enabled = true;
        refresh_minutes = 30;
        unit = "imperial";
        effects = true;
      };
      dock = {
        enabled = false;
      };
      widget = {
        tray = {
          drawer = true;
          drawer_columns = 3;
          drawer_item_size = 20;
        };
        notifications = {
          hide_when_no_unread = false;
        };
        weather = {
          max_length = 180;
          show_condition = true;
          show_temperature = true;
        };
        clock = {
          format = "{:%a %B %d %I:%M:%S %p %Z}";
          vertical_format = "{:%H:%M}";
        };
        keyboard_layout = {
          show_icon = true;
          show_label = true;
        };
        network = {
          show_label = false;
        };
        bluetooth = {
          show_label = true;
        };
        workspaces = {
          minimal = true;
          hide_when_empty = true;
        };
        spacer = {
          type = "spacer";
          length = 18;
        };
        weather = {
          showBackground = true;
          roundedCorners = true;
        };
        cpu = {
          type = "sysmon";
          stat = "cpu_usage";
        };
        cpu-graph = {
          type = "sysmon";
          stat = "cpu_usage";
          display = "graph";
          show_label = false;
        };
        temp = {
          type = "sysmon";
          stat = "cpu_temp";
        };
        ram = {
          type = "sysmon";
          stat = "ram_used";
        };
        disk = {
          type = "sysmon";
          stat = "disk_pct";
          path = "/";
        };
        wifi-download = {
          type = "sysmon";
          stat = "net_rx";
          interface = "wlan0";
        };
        wifi-upload = {
          type = "sysmon";
          stat = "net_tx";
          network_speed_unit = "mb"; # auto | kb | mb
          network_speed_compact = true; # show "1.2M" instead of "1.2 MB/s"
        };
        audio-vis = {
          type = "audio_visualizer";
          width = 64;
          bands = 20;
          centered = true;
          show_when_idle = true;
          color_1 = "primary";
          color_2 = "secondary";
        };
      };
      bar = {
        order = [ "main" ];
        main = {
          position = "top";
          enabled = true;
          auto_hide = false;
          reserve_space = true;
          density = "comfortable";
          layer = "top";
          thickness = 34;
          background_opacity = 1.0;
          start = [
            "clock"
            "spacer"
            "weather"
            "spacer"
            "brightness"
            "volume"
            "spacer"
            "bluetooth"
            "spacer"
            "keyboard_layout"
            "spacer"
            "network"
          ];
          center = [
            "workspaces"
          ];
          end = [
            "audio-vis"
            "spacer"
            "sysmon"
            "spacer"
            "battery"
            "spacer"
            "control-center"
            "spacer"
            "notifications"
            "tray"
          ];
        };
      };
    };
  };

  systemd.user = {
    services = {
      noctalia-shell = {
        Unit = {
          Description = "Noctalia Shell - Wayland desktop shell";
          Documentation = "https://docs.noctalia.dev";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${config.programs.noctalia.package}/bin/noctalia";
          RemainAfterExit = true;
          Environment = [
            "QT_QPA_PLATFORM=wayland"
            "WAYLAND_DISPLAY=wayland-1"
            "XDG_RUNTIME_DIR=%t"
            # "NOCTALIA_WALLHAVEN_API_KEY=$(cat ${config.age.secrets.wallhaven-token.path})"
          ];
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
  };
}
