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

  xdg.dataFile."noctalia/state.toml".source = config.age.secrets.noctalia_state_toml.path;

  programs.noctalia = {
    enable = true;
    package = config.lib.pamShim.replacePam pkgs.noctalia;
    systemd.enable = false;
    settings = {
      lockscreen = {
        enabled = true;
        fingerprint = true;
        allow_empty_password = false;
        blurred_desktop = true;
        blur_intensity = 0.5;
        tint_intensity = 0.3;
        monitors = [ ];
      };
      calendar = {
        enabled = true;
        refresh_minutes = 15;
        account = {
          baikal = {
            type = "caldav";
            name = "baikal";
            provider = "custom";
            server_url = "https://cal.devtechnica.com/dav.php";
            username = "sreedev";
            calendars = [ ]; # optional discovered collection ids; empty = all
          };
        };
      };
      plugins = {
        enabled = [ "noctalia/wallhaven" ];
      };
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      backdrop = {
        enabled = true;
        blur_intensity = 0.5; # 0.0 = no blur, 1.0 = maximum blur
        tint_intensity = 0.3; # 0.0 = no tint, 1.0 = fully opaque tint
      };
      wallpaper = {
        enabled = true;
        fill_mode = "crop"; # center | crop | fit | stretch | repeat | span
        transition = [
          "fade"
          "wipe"
          "disc"
          "stripes"
          "zoom"
          "honeycomb"
        ];
        transition_duration = 900;
        edge_smoothness = 0.3;
        transition_on_startup = false;
        default.path = "${opts.directories.wallpapers}/${opts.desktop.wallpaper}";
        directory = opts.directories.wallpapers;
        per_monitor_directories = false;
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
          show_condition = false;
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
          style = "minimal";
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
      lockscreen_widgets = {
        enabled = true;
        widget = {
          clock_main = {
            type = "clock";
            # output = "DP-1";
            cx = 1600.0;
            cy = 120.0;
            box_width = 360.0;
            box_height = 120.0;
            rotation = 0.0;
            settings = {
              format = "{:%H:%M}";
            };
          };
          audio_main = {
            type = "fancy_audio_visualizer";
            # output = "DP-1";
            cx = 960.0;
            cy = 540.0;
            box_width = 0.0;
            box_height = 0.0;
            rotation = 0.0;
            settings = {
              visualization_mode = "bars_rings";
              sensitivity = 1.5;
              rotation_speed = 0.5;
              bar_width = 0.6;
              ring_opacity = 0.8;
              inner_diameter = 0.7;
              bloom_intensity = 0.5;
              fade_when_idle = true;
              primary_color = "primary";
              secondary_color = "secondary";
            };
          };
        };
      };
      bar = {
        order = [ "main" ];
        main = {
          position = "top";
          enabled = true;
          shadow = false;
          margin_ends = 0;
          padding = 14;
          margin_edge = 0;
          radius = 0;
          auto_hide = false;
          widget_spacing = 18;
          reserve_space = true;
          density = "comfortable";
          layer = "top";
          thickness = 34;
          background_opacity = 1.0;
          start = [
            "clock"
            "weather"
            "brightness"
            "volume"
            "bluetooth"
            "keyboard_layout"
            "network"
          ];
          center = [
            "workspaces"
          ];
          end = [
            "audio-vis"
            "cpu-graph"
            "temp"
            "battery"
            "control-center"
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
