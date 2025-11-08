{
  config,
  pkgs,
  opts,
  ...
}:
let
  gpu = import ./modules/gpu.nix { inherit pkgs; };
  noctalia = pkgs.writeShellScriptBin "noctalia" ''
    QT_QPA_PLATFORM=wayland ${config.programs.noctalia-shell.package}/bin/noctalia-shell $@
  '';
in
{

  systemd.user.services.noctalia-shell.Service.Environment = [
    "QT_QPA_PLATFORM=wayland"
    "WAYLAND_DISPLAY=wayland-1"
    "XDG_RUNTIME_DIR=%t"
  ];

  home.packages = [ noctalia ];

  programs.noctalia-shell = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.noctalia;
    systemd.enable = true;
    colors = with config.lib.stylix.colors; {
      mError = "#${base08}";
      mOnError = "#${base00}";
      mOnPrimary = "#${base00}";
      mOnSecondary = "#${base00}";
      mOnSurface = "#${base04}";
      mOnSurfaceVariant = "#${base04}";
      mOnTertiary = "#${base00}";
      mOutline = "#${base02}";
      mPrimary = "#${base0B}";
      mSecondary = "#${base0A}";
      mShadow = "#${base00}";
      mSurface = "#${base00}";
      mSurfaceVariant = "#${base01}";
      mTertiary = "#${base0D}";
    };
    settings = {
      dock = {
        enabled = false;
      };
      controlCenter = {
        position = "center";
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      notifications = {
        enabled = true;
        doNotDisturb = false;
        monitors = [ ];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
      };
      appLauncher = {
        enableClipboardHistory = false;
        position = "center";
        backgroundOpacity = 1;
        pinnedExecs = [ ];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "alacritty -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = opts.directories.wallpapers;
        enableMultiMonitorDirectories = false;
        recursiveSearch = true;
        setWallpaperOnAllMonitors = true;
        defaultWallpaper = "${opts.directories.wallpapers}/${opts.desktop.wallpaper}";
        fillMode = "crop";
        fillColor = "#000000";
        randomEnabled = false;
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
        monitors = [ ];
        panelPosition = "follow_bar";
      };
      bar = {
        density = "comfortable";
        monitors = [ ];
        marginVertical = 0.25;
        marginHorizontal = 0.25;
        position = "top";
        floating = false;
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = false;
            }
            { id = "WiFi"; }
            { id = "Bluetooth"; }
            {
              id = "Brightness";
              displayMode = "onhover";
            }
            {
              id = "Microphone";
              displayMode = "onhover";
            }
            {
              id = "Volume";
              displayMode = "onhover";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              id = "CustomButton";
              icon = "cpu-2";
              leftClickExec = "alacritty -e nvtop";
              rightClickExec = "";
              middleClickExec = "";
              textCommand = "${gpu}/bin/gpu";
              textIntervalMs = 3000;
            }
            {
              formatHorizontal = "ddd MMMM dd  hh:mm:ss AP t";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = false;
              usePrimaryColor = false;
              useCustomFont = true;
              customFont = "Iosevka Nerd Font";
            }
            {
              id = "SystemMonitor";
              showCpuUsage = true;
              showCpuTemp = true;
              showMemoryUsage = true;
              showMemoryAsPercent = false;
              showNetworkStats = false;
              showDiskUsage = false;
            }
            {
              id = "NotificationHistory";
              showUnreadBadge = true;
              hideWhenZero = true;
            }
            { id = "Tray"; }
          ];
        };
      };
      colorSchemes = {
        darkMode = true;
        generateTemplatesForPredefined = true;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        matugenSchemeType = "scheme-fruit-salad";
        predefinedScheme = "Monochrome";
        schedulingMode = "off";
        useWallpaperColors = false;
      };
      setupCompleted = true;
      general = {
        avatarImage = "";
        dimDesktop = true;
        radiusRatio = 0.2;
        scaleRatio = 1.15;
      };
      ui = {
        fontDefault = "Iosevka Nerd Font";
        fontFixed = "Iosevka Nerd Font";
        fontDefaultScale = 1.15;
        fontFixedScale = 1.15;
        tooltipsEnabled = true;
        panelsOverlayLayer = true;
      };
      location = {
        monthBeforeDay = true;
        name = "New York, United States";
      };
    };
  };
}
