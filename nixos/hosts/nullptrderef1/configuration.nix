{ config, pkgs, secrets, opts, system, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/containers
    ../common/services
    ../common/scripts
  ];

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
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  networking = {
    hostName = opts.hostname;
    domain = "nullptr.sh";
    search = [ opts.hostname ];
    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp2s0";
    };
    wireless = {
      iwd = {
        enable = true;
        settings = {
          IPV6 = { Enabled = false; };
          Settings = { AutoConnect = true; };
        };
      };
    };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      insertNameservers = opts.nameservers;
    };

    nameservers = pkgs.lib.mkForce opts.nameservers;

    enableIPv6 = false;

    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ ftp https ssh ]);
      allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ ftp ssh ]);
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
    password = secrets.nullptrderef1_system_password;
    openssh.authorizedKeys.keys = with opts.publicKeys; [
      devstation
      neoserver
      olivetin
      rpi4b
      terminus
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
    packages = with pkgs; [ iosevka nerdfonts ];
    fontconfig = { enable = true; };
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    bcc
    busybox
    clang
    cmake
    cryptsetup
    curl
    dhcpcd
    fasm-bin
    ffmpeg
    git
    git-crypt
    gnumake
    home-manager
    hwinfo
    icecast
    iwd
    kexec-tools
    lshw
    man
    mosh
    mullvad
    mullvad-vpn
    netcat-gnu
    openresolv
    openssl
    openvpn
    ouch
    p7zip
    parallel
    parted
    pciutils
    progress
    sshfs
    strace
    traceroute
    unzip
    zfs
    zip
    zmap
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
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
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
      port = pkgs.lib.strings.toInt opts.ports.cockpit;
      openFirewall = true;
      settings = {
        WebService =
          {
            AllowUnencrypted = true;
            Origins = "https://cockpit.nullptr.sh";
          };
      };
    };

    zfs = {
      autoScrub = {
        enable = true;
        interval = "monthly";
        pools = [ "dpool0" "dpool1" ];
      };

      autoSnapshot = {
        enable = true;
        daily = 3;
        flags = "-p -u";
      };
    };
  };

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  programs = {
    mtr.enable = true;
    zsh.enable = true;
    mosh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}

