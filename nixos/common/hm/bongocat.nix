{ pkgs, ... }:
let
  bongocat-config-path = "${builtins.getEnv "XDG_CONFIG_HOME"}/bongocat/bongocat.conf";
in 
{
  home.packages = with pkgs; [
    bongocat
  ];

  systemd.user = {
    services = {
      bongocat = {
        Unit = {
          Description = "Bongocat";
          PartOf = "graphical-session.target";
          After = "graphical-session.target";
        };
        Service = {
          ExecStart = "${pkgs.bongocat}/bin/bongocat -c ${bongocat-config-path}";
          Restart = "always";
          RestartSec = 3;
        };
        Install = {
          WantedBy = [
            "graphical-session.target"
          ];
        };
      };
    };
  };

  home.file = {
    "${bongocat-config-path}" = {
      enable = true;
      text = ''
        # Position & Size
        cat_height=50
        cat_align=center
        cat_x_offset=750
        cat_y_offset=6

        # Appearance
        enable_antialiasing=1
        overlay_height=60
        overlay_opacity=0
        overlay_position=top
        layer=top
        mirror_x=0
        mirror_y=0

        # Input device (run bongocat-find-devices to find yours)
        keyboard_device=/dev/input/event18  # Keychron Keychron Q2 Pro

        # Multi-monitor (optional - auto-detects by default)
        monitor=DP-4

        # Sleep mode (optional)
        # idle_sleep_timeout=300
        # enable_scheduled_sleep=0
        # sleep_begin=22:00
        # sleep_end=06:00
      '';
    };
  };
}
