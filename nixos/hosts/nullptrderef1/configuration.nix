{ config, pkgs, nixpkgs-stable, opts, system, ... }:
{
  imports = [
    ../common/containers
    ../common/scripts
    ../common/services
    ../../../secrets/mappings.nix
    ./hardware-configuration.nix
  ];

  documentation.nixos.enable = true;

  nix = {
    package = pkgs.nixVersions.stable;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      allowed-users = [ "admin" ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      show-trace = true;
      trusted-substituters = [ "admin" ];
      trusted-users = [ "admin" ];
      warn-dirty = true;
    };
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
      intel-compute-runtime
      intel-media-driver
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
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
      allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ ftp https ssh tailscale_p2p tailscale_direct ]);
      allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (with opts.ports; [ ftp ssh tailscale_p2p tailscale_direct ]);
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
    hashedPasswordFile = config.age.secrets.nullptrderef1_admin_password.path;
    openssh.authorizedKeys.keys = with opts.publicKeys; [
      devstation
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
      "scanner"
      "sshd"
      "vboxusers"
      "video"
      "wheel"
      "render"
    ];
  };

  fonts = {
    packages = with pkgs; [ nerd-fonts.iosevka nerd-fonts.iosevka-term ];
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
    oxker
    p7zip
    parallel
    parted
    pciutils
    progress
    sabnzbd
    smartmontools
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
    timesyncd.enable = true;
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

    zfs = {
      autoScrub = {
        enable = true;
        interval = "monthly";
        pools = [ "dpool0" ];
      };
    };

  };

  services.udev.packages = [ pkgs.vaapiIntel pkgs.intel-media-driver ];

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

  system.switch = {
    enable = true;
  };

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}

