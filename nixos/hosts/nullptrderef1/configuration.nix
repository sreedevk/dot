# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, secrets, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  documentation.nixos.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      warn-dirty = true;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    package = pkgs.nixFlakes;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override {
          enableHybridCodec = true;
        };
      };
    };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelParams = [ "nohibernate" ];
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nullptrderef1";
    wireless = {
      iwd = {
        enable = true;
        settings = {
          IPV6 = {
            Enabled = false;
          };
          Settings = {
            AutoConnect = true;
          };
        };
      };
    };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      insertNameservers = [
        "9.9.9.9"
        "149.112.112.112"
        "194.242.2.5"
      ];
    };
    nameservers = pkgs.lib.mkForce [
      "9.9.9.9"
      "149.112.112.112"
      "194.242.2.5"
    ];
    enableIPv6 = false;
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [
        13378
        21
        22
        2342
        3001
        3333
        443
        4848
        5000
        9090
        5299
        53
        6660
        6800
        6880
        6881
        6969
        7777
        7878
        80
        8000
        8001
        8008
        8080
        8081
        8083
        8096
        8181
        8191
        8686
        8787
        8808
        8989
        9000
        9117
        9696
        9999
        19999
        32400
      ];
      allowedUDPPorts = [
        13378
        21
        22
        53
        6881
        8096
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "system root user & administrator";
    password = secrets.system.password;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyTIQBuC8gK9HjVViXha1VVTc8mStsrWU1umEM0puuP"
    ];
    extraGroups = [
      "audio"
      "bluetooth"
      "disk"
      "docker"
      "lp"
      "networkmanager"
      "ntfy-sh"
      "scanner"
      "sshd"
      "vboxusers"
      "video"
      "wheel"
    ];
  };

  fonts = {
    packages = with pkgs; [
      iosevka
      nerdfonts
    ];

    fontconfig = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    amfora
    antibody
    babashka
    bat
    btop
    cava
    clang
    cmake
    cryptsetup
    curl
    delta
    dhcpcd
    dig
    direnv
    du-dust
    duf
    emacs
    eza
    fasm-bin
    fastfetch
    fd
    fzf
    gh
    git
    git-crypt
    glab
    glow
    gnumake
    gping
    hexyl
    hledger
    htop
    hyperfine
    ipcalc
    irssi
    iwd
    jaq
    jq
    lf
    man
    minicom
    mosh
    mullvad
    mullvad-vpn
    ncdu
    neovim
    netcat-gnu
    newsboat
    ngrok
    nmap
    openresolv
    openvpn
    ouch
    p7zip
    pandoc
    parallel
    procs
    restic
    ripgrep
    ripgrep-all
    rsync
    ruby
    rustup
    sshfs
    starship
    stow
    strace
    tailspin
    taskwarrior
    taskwarrior-tui
    tmux
    tokei
    traceroute
    unzip
    wget
    xh
    xxd
    yt-dlp
    zip
    zoxide
    zsh
  ];

  services = {
    flatpak.enable = false;
    packagekit.enable = true;
    udisks2.enable = true;
    dbus.enable = true;
    printing.enable = false;
    xserver = {
      enable = false;
      xkb.layout = "us";
      xkb.options = "ctrl:nocaps";
    };
    openssh = {
      enable = true;
      allowSFTP = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
    adguardhome = {
      enable = true;
      mutableSettings = true;
      openFirewall = true;
      extraArgs = [ ];
      settings = {
        http = {
          address = "0.0.0.0:8000";
        };
        dns = {
          bindHosts = "0.0.0.0";
          filtering = {
            protection_enabled = true;
            filtering_enabled = true;
          };
          rewrites = [
            {
              domain = "nullptrderef1";
              answer = "192.168.1.179";
            }
            {
              domain = "nullptrderef1.local";
              answer = "192.168.1.179";
            }
            {
              domain = "rpi4b.local";
              answer = "192.168.1.152";
            }
            {
              domain = "devstation.local";
              answer = "192.168.1.249";
            }
          ];
          filters = [
            {
              enabled = true;
              url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
              name = "StevenBlack's List";
              ID = 1;
            }
            {
              enabled = true;
              url = "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt";
              name = "DeveloperDan's Advertisements & Tracking List";
              ID = 15;
            }
            {
              enabled = true;
              url = "https://easylist.to/easylist/easylist.txt";
              name = "EasyList Basic";
              ID = 16;
            }
            {
              enabled = true;
              url = "https://easylist.to/easylist/easyprivacy.txt";
              name = "EasyList Privacy";
              ID = 17;
            }
            {
              enabled = true;
              url = "https://secure.fanboy.co.nz/fanboy-annoyance.txt";
              name = "Fanboy's Annoyances";
              ID = 18;
            }
            {
              enabled = true;
              url = "https://easylist.to/easylist/fanboy-social.txt";
              name = "Fanboy's Social";
              ID = 19;
            }
            {
              enabled = true;
              url = "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt";
              name = "Fanboy's Cookiemonster";
              ID = 20;
            }
          ];
          upstream_dns = [
            "9.9.9.9"
            "https://dns10.quad9.net/dns-query"
            "https://extended.dns.mullvad.net/dns-query"
          ];
          upstream_mode = "load_balance";
        };
      };
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    mullvad-vpn = {
      enable = true;
    };

    cockpit = {
      enable = true;
      port = 8008;
      openFirewall = true;
      settings = {
        WebService = {
          AllowUnencrypted = true;
        };
      };
    };

    netdata = {
      enable = true;
      config = {
        global = {
          "page cache size" = 32;
          "update every" = 15;
        };
        ml = {
          "enabled" = "yes";
        };
      };
    };
  };

  systemd.services."mullvad-daemon".postStart =
    let
      mullvad = config.services.mullvad-vpn.package;
    in
    ''
      while ! ${mullvad}/bin/mullvad status > /dev/null; do sleep 1; done
      ${mullvad}/bin/mullvad account get | grep "Not logged in" && ${mullvad}/bin/mullvad account login ${secrets.mullvad.account}
      ${mullvad}/bin/mullvad relay set location ${secrets.mullvad.location}
      ${mullvad}/bin/mullvad lockdown-mode set on
      ${mullvad}/bin/mullvad lan set allow
      ${mullvad}/bin/mullvad tunnel set ipv6 off
      ${mullvad}/bin/mullvad dns set custom "127.0.0.1" "9.9.9.9"
      ${mullvad}/bin/mullvad auto-connect set on
    '';

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    mtr.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # PODMAN CONTAINER BASED SERVICES
  virtualisation.oci-containers.containers =
    let
      lanAddress = "192.168.1.179";
      timeZone = "America/New_York";

      downloadsDir = "/mnt/data/downloads/";
      torrentsWatchDir = "/mnt/data/torrents/";

      applicationConfigDir = "/mnt/data/applications";

      moviesDir = "/mnt/data/media/movies/";
      tvDir = "/mnt/data/media/shows/";
      audioBooksDir = "/mnt/data/media/audiobooks/";
      musicDir = "/mnt/data/media/music/";
      videosDir = "/mnt/data/media/videos/";
      imagesDir = "/mnt/data/media/images/";
      booksDir = "/mnt/data/media/books/";
      magazinesDir = "/mnt/data/media/magazines/";

      encTvDir = "/mnt/enc_data_drive/media/shows/";
      encVideosDir = "/mnt/enc_data_drive/media/videos/";

      adminUID = "1000";
      adminGID = "100";
    in
    {
      # Jellyfin Media Player
      "jellyfin" = {
        autoStart = true;
        image = "jellyfin/jellyfin";
        volumes = [
          "${applicationConfigDir}/jellyfin/config:/config"
          "${applicationConfigDir}/jellyfin/cache/:/cache"
          "${applicationConfigDir}/jellyfin/log/:/log"
          "${moviesDir}:/movies"
          "${tvDir}:/tv"
          "${encTvDir}:/enctv"
          "${audioBooksDir}:/audiobooks"
          "${musicDir}:/music"
        ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "8096:8096" ];
        environment = {
          JELLYFIN_LOG_DIR = "/log";
        };
      };

      # Plex Media Server
      "plex" = {
        autoStart = true;
        image = "plexinc/pms-docker";
        extraOptions = [ "--network=host" ];
        volumes = [
          "${applicationConfigDir}/plex/database/:/config"
          "${applicationConfigDir}/plex/transcode/:/transcode"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
          PLEX_CLAIM = secrets.plex.claim;
        };
      };

      # qBittorrent P2P Torrent Client
      "qbittorrent-nox" = {
        autoStart = true;
        image = "qbittorrentofficial/qbittorrent-nox:4.6.4-1";
        ports = [ "6881:6881/tcp" "6881:6881/udp" "8001:8001/tcp" ];
        environment = {
          QBT_EULA = "accept";
          QBT_VERSION = "4.6.4-1";
          QBT_WEBUI_PORT = "8001";
          TZ = timeZone;
          USER_UID = adminUID;
          USER_GID = adminGID;
        };
        volumes = [
          "${applicationConfigDir}/qbittorrent/config/:/config"
          "${applicationConfigDir}/vuetorrent:/vuetorrent"
          "${downloadsDir}:/downloads"
          "${torrentsWatchDir}:/torrents"
          "${imagesDir}:/images"
          "${videosDir}:/videos"
          "${booksDir}:/books"
          "${magazinesDir}:/magazines"
        ];
        extraOptions = [ "--network=host" ];
      };

      # Radarr Movies Indexer
      "radarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/radarr";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        dependsOn = [ "qbittorrent-nox" ];
        volumes = [
          "${applicationConfigDir}/Radarr/:/config"
          "${moviesDir}:/movies"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "7878:7878" ];
        environment = {
          TZ = timeZone;
        };
      };

      # Sonarr TV Indexer
      "sonarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/sonarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Sonarr/:/config"
          "${tvDir}:/tv"
          "${encTvDir}:/enctv"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "8989:8989" ];
        environment = {
          TZ = timeZone;
        };
      };

      # Lidarr Music Indexer
      "lidarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/lidarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Lidarr/:/config"
          "${musicDir}:/music"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "8686:8686" ];
        environment = {
          TZ = timeZone;
        };
      };

      # Readarr Books Indexer
      "readarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/readarr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Readarr/:/config"
          "${booksDir}:/books"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "8787:8787" ];
        environment = {
          TZ = timeZone;
        };
      };

      "whisparr" = {
        autoStart = true;
        image = "ghcr.io/hotio/whisparr";
        dependsOn = [ "qbittorrent-nox" ];
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Whisparr/:/config"
          "${videosDir}:/videos"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "6969:6969" ];
        environment = {
          TZ = timeZone;
        };
      };

      # Flaresolver Cloudflare Challenge Solver
      "flareSolverr" = {
        autoStart = true;
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "8191:8191" ];
        environment = {
          LOG_LEVEL = "info";
        };
      };

      # Prowlarr Indexer Source Management
      "prowlarr" = {
        autoStart = true;
        image = "ghcr.io/hotio/prowlarr";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        dependsOn = [ "flareSolverr" ];
        volumes = [
          "${applicationConfigDir}/Prowlarr/:/config"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "9696:9696" ];
        environment = {
          TZ = lanAddress;
        };
      };

      # Jackett Indexer Source Management
      "jackett" = {
        autoStart = true;
        image = "lscr.io/linuxserver/jackett:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        dependsOn = [ "flareSolverr" ];
        environment = {
          TZ = timeZone;
          AUTO_UPDATE = "true";
        };
        volumes = [
          "${applicationConfigDir}/Jackett:/config"
          "${downloadsDir}:/downloads"
        ];
        ports = [ "9117:9117" ];
      };

      "stash" = {
        autoStart = true;
        image = "ghcr.io/hotio/stash";
        volumes = [
          "${applicationConfigDir}/Stash/:/config"
          "${videosDir}:/videos"
          "${imagesDir}:/images"
        ];
        ports = [ "9999:9999" ];
        environment = {
          TZ = timeZone;
        };
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
      };

      # Server Homepage
      "homer" = {
        autoStart = true;
        image = "b4bz/homer:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/Homer/:/www/assets"
        ];
        ports = [ "80:8080" ];
      };

      # RSS Feed Server, Scanner, Indexer & Organizer
      "freshRSS" = {
        autoStart = true;
        image = "freshrss/freshrss:edge";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/FreshRSS/data/:/var/www/FreshRSS/data"
          "${applicationConfigDir}/FreshRSS/extensions/:/var/www/FreshRSS/extensions"
        ];
        ports = [ "8808:80" ];
        environment = {
          TZ = timeZone;
          CRON_MIN = "2,32";
        };
      };

      # Book Server
      "kavita" = {
        autoStart = true;
        image = "jvmilazz0/kavita";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "5000:5000" ];
        volumes = [
          "${applicationConfigDir}/Kavita:/kavita/config"
          "${booksDir}:/books"
          "${magazinesDir}:/magazines"
        ];
      };

      # AudioBook Server
      "audiobookshelf" = {
        autoStart = true;
        image = "ghcr.io/advplyr/audiobookshelf:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "13378:80" ];
        volumes = [
          "${applicationConfigDir}/audiobookshelf:/config"
          "${audioBooksDir}:/audiobooks"
        ];
        environment = {
          TZ = timeZone;
        };
      };

      # Notification Server
      "ntfy" = {
        autoStart = true;
        image = "binwiederhier/ntfy";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        cmd = [ "serve" ];
        environment = {
          TZ = timeZone;
        };
        ports = [ "7777:80" ];
        volumes = [
          "${applicationConfigDir}/ntfy/cache:/var/cache/ntfy"
          "${applicationConfigDir}/ntfy/data/:/etc/ntfy"
        ];
      };

      # Server File Browser WebUI
      "filebrowser" = {
        autoStart = true;
        image = "filebrowser/filebrowser";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "6660:80" ];
        volumes = [
          "/mnt/data/:/srv"
          "${applicationConfigDir}/filebrowser/settings.json:/config/settings.json"
          "${applicationConfigDir}/filebrowser/filebrowser.db:/config/filebrowser.db"
        ];
        environment = {
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Youtube Media Downloader
      "metube" = {
        autoStart = true;
        image = "ghcr.io/alexta69/metube";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "8081:8081" ];
        volumes = [
          "${videosDir}:/downloads"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
          YTDL_OPTIONS = ''
            {
              "writesubtitles": true,
              "subtitleslangs": ["en","-live_chat"],
              "updatetime": false,
              "postprocessors": [
                { 
                  "key":"Exec",
                  "exec_cmd":"chmod 0664",
                  "when":"after_move"
                },
                {
                  "key": "FFmpegEmbedSubtitle",
                  "already_have_subtitle": false
                },
                {
                  "key": "FFmpegMetadata",
                  "add_chapters": true
                }
              ]
            } 
          '';
        };
      };

      # Aria2 Download Manager
      "aria2" = {
        autoStart = true;
        image = "abcminiuser/docker-aria2-with-webui:latest-ng";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        ports = [ "6800:6800" "6880:80" ];
        volumes = [
          "${downloadsDir}:/downloads"
          "${applicationConfigDir}/aria2:/conf"
        ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Linkding Bookmarks Manager
      "linkding" = {
        autoStart = true;
        image = "sissbruecker/linkding:latest";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/linkding:/etc/linkding/data"
        ];
        ports = [ "9090:9090" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Automation Bots
      "huginn" = {
        autoStart = true;
        image = "ghcr.io/huginn/huginn";
        ports = [ "3333:3000" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      # Service Health Monitoring
      "uptime-kuma" = {
        autoStart = true;
        image = "louislam/uptime-kuma:1";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" ];
        volumes = [
          "${applicationConfigDir}/uptime-kuma/:/app/data"
        ];
        ports = [ "3001:3001" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
        };
      };

      "photoprism" = {
        autoStart = true;
        image = "photoprism/photoprism";
        extraOptions = [ "--add-host=nullptrderef1:${lanAddress}" "--privileged" ];
        volumes = [
          "${applicationConfigDir}/photoprism/:/photoprism/storage"
          "${imagesDir}:/photoprism/originals"
        ];
        ports = [ "2342:2342" ];
        environment = {
          TZ = timeZone;
          PUID = adminUID;
          PGID = adminGID;
          PHOTOPRISM_UPLOAD_NSFW = "true";
          PHOTOPRISM_ADMIN_PASSWORD = secrets.photoprism.password;
        };
      };
    };

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11"; # Did you read the comment?
}

