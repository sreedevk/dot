{ config, lib, pkgs, secrets, ... }:

{
  imports = [ ./hardware-configuration.nix ./containers ./services ];

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
        "127.0.0.1"
        "149.112.112.112"
        "194.242.2.5"
        "9.9.9.9"
      ];
    };
    nameservers = pkgs.lib.mkForce [
      "127.0.0.1"
      "149.112.112.112"
      "194.242.2.5"
      "9.9.9.9"
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
        3100
        32400
        3333
        443
        4533
        4848
        5000
        5055
        5299
        53
        6003
        6660
        6767
        6800
        6880
        6881
        6969
        7474
        7575
        7777
        7878
        80
        8000
        8001
        8004
        8008
        8024
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
        9080
        9090
        9117
        9443
        9696
        9801
        9999
        53589
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
    openssl
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
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
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

