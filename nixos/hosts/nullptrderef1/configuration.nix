{ config, lib, pkgs, secrets, ... }:

{
  imports = [ ./hardware-configuration.nix ./containers ];

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
        19999
        21
        22
        2342
        3001
        32400
        3333
        443
        4848
        5000
        5055
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
        8004
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
        9090
        9117
        9696
        9999
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

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
  };

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
    babashka
    cava
    clang
    cmake
    cryptsetup
    curl
    dhcpcd
    dig
    direnv
    fasm-bin
    gnumake
    iwd
    man
    minicom
    mosh
    mullvad
    mullvad-vpn
    netcat-gnu
    ngrok
    nmap
    openresolv
    openvpn
    ouch
    p7zip
    pandoc
    parallel
    restic
    ripgrep
    ripgrep-all
    rsync
    rustup
    sshfs
    strace
    starship
    traceroute
    unzip
    wget
    zip
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

  programs = {
    mtr.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}

