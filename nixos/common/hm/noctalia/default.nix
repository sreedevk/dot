{
  config,
  pkgs,
  opts,
  ...
}:
let
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

  home.packages = with pkgs; [
    noctalia
    evolution-data-server
    matugen
    roboto
  ];

  programs.noctalia-shell = {
    enable = true;
    package = config.lib.nixGL.wrap (config.lib.pamShim.replacePam pkgs.noctalia);
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
      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        backgroundOpacity = 1;
        enabledTypes = [
          0
          1
          2
          4
        ];
        monitors = [
          "eDP-1"
        ];
      };
      audio = {
        cavaFrameRate = 120;
        mprisBlacklist = [ ];
        preferredPlayer = "";
        visualizerType = "linear";
        volumeOverdrive = false;
        volumeStep = 5;
        externalMixer = "pwvucontrol || pavucontrol";
      };
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        largeButtonsStyle = false;
        showNumberLabels = true;
        powerOptions = [
          {
            action = "lock";
            enabled = true;
          }
          {
            action = "suspend";
            enabled = true;
          }
          {
            action = "hibernate";
            enabled = true;
          }
          {
            action = "reboot";
            enabled = true;
          }
          {
            action = "logout";
            enabled = true;
          }
          {
            action = "shutdown";
            enabled = true;
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
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = true;
          volume = 0.5;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "discord,slack,firefox,chrome,chromium,edge";
        };
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
        marginVertical = 0.20;
        marginHorizontal = 0.25;
        position = "top";
        floating = false;
        showCapsule = false;
        widgets = {
          left = [
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
              id = "Spacer";
              width = 10;
            }
            {
              id = "Brightness";
              displayMode = "alwaysShow";
            }
            {
              id = "Microphone";
              displayMode = "alwaysShow";
            }
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "KeyboardLayout";
              displayMode = "forceOpen";
            }
            { id = "Bluetooth"; }
            {
              id = "WiFi";
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
              id = "Battery";
              displayMode = "onhover";
              warningThreshold = 30;
            }
            {
              id = "Spacer";
              width = 10;
            }
            {
              id = "SystemMonitor";
              showCpuUsage = true;
              showCpuTemp = true;
              showMemoryUsage = true;
              showMemoryAsPercent = false;
              showNetworkStats = true;
              showDiskUsage = true;
              showGpuTemp = true;
            }
            {
              id = "Spacer";
              width = 10;
            }
            {
              id = "NotificationHistory";
              showUnreadBadge = true;
              hideWhenZero = true;
            }
            {
              id = "Tray";
              blacklist = [ ];
              colorizeIcons = false;
            }
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
      brightness = {
        enableDdcSupport = false;
      };
      desktopWidgets = {
        enabled = true;
        gridSnap = true;
        monitorWidgets = [ ];
      };
      templates = {
        gtk = false;
        qt = false;
        kcolorscheme = false;
        alacritty = false;
        kitty = false;
        ghostty = false;
        foot = false;
        wezterm = false;
        fuzzel = false;
        discord = false;
        pywalfox = false;
        vicinae = false;
        walker = false;
        code = false;
        spicetify = false;
        telegram = false;
        cava = false;
        yazi = false;
        emacs = false;
        niri = false;
        hyprland = false;
        mango = false;
        zed = false;
        helix = false;
        enableUserTemplates = false;
      };
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = 4000;
        dayTemp = 6500;
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };
      ui = {
        fontDefault = "Roboto";
        fontFixed = "Iosevka Nerd Font";
        fontDefaultScale = 1.15;
        fontFixedScale = 1.15;
        tooltipsEnabled = true;
        panelsOverlayLayer = true;
      };
      location = {
        monthBeforeDay = true;
        name = "New York, United States";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = true;
        use12hourFormat = true;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
      };
      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        tempPollingInterval = 3000;
        gpuPollingInterval = 3000;
        enableNvidiaGpu = true;
        memPollingInterval = 3000;
        diskPollingInterval = 3000;
        networkPollingInterval = 3000;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
      };
    };
  };
}
