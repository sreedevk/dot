{ config
, pkgs
, opts
, inputs
, ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  documentation.nixos.enable = true;

  virtualisation = {
    spiceUSBRedirection.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = false;
      autoPrune.enable = true;
    };
  };

  nix = {
    package = pkgs.nixVersions.stable;
    settings = {
      allowed-users = [ "admin" ];
      auto-optimise-store = true;
      http2 = false;
      show-trace = true;
      trusted-users = [ "admin" ];
      warn-dirty = true;

      experimental-features = [
        "nix-command"
        "flakes"
        "recursive-nix"
      ];

      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://numtide.cachix.org"
        "https://colmena.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:Ji+ZysQ8GqEtvQF3o4O5q6c3y8C3b2q9p5g6s7d8e9k="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      ];

      trusted-substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://numtide.cachix.org"
        "https://colmena.cachix.org"
      ];

    };
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
    ];
    fontconfig = {
      enable = true;
    };
  };

  nixpkgs = {
    overlays = import ../../common/overlays { inherit inputs; };
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };
    };
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
    dive
    fasm-bin
    ffmpeg
    git
    git-crypt
    gnumake
    home-manager
    hwinfo
    inotify-info
    inotify-tools
    iwd
    kexec-tools
    lm_sensors
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
    podman-compose
    podman-tui
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

  programs = {
    mtr.enable = true;
    zsh.enable = true;
    mosh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

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
        PermitRootLogin = "yes";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };

      # Automatically Generated Host Keys
      hostKeys = [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };

    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
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

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
    polkit.enable = true;
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
      insertNameservers = opts.nameservers;
    };

    nameservers = pkgs.lib.mkForce opts.nameservers;
    enableIPv6 = false;

    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = builtins.map pkgs.lib.strings.toInt (
        with opts.ports;
        [
          ftp
          https
          ssh
          tailscale_p2p
          tailscale_direct
        ]
      );
      allowedUDPPorts = builtins.map pkgs.lib.strings.toInt (
        with opts.ports;
        [
          ftp
          ssh
          tailscale_p2p
          tailscale_direct
        ]
      );
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      libvdpau-va-gl
      vaapiIntel
      libva-vdpau-driver
    ];
  };

  users.users.admin = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "system root user & administrator";
    hashedPasswordFile = config.age.secrets.farfalle_admin_password.path;
    openssh.authorizedKeys.keys = with opts.publicKeys; [
      devstation
      olivetin
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


  services.udev.packages = [
    pkgs.vaapiIntel
    pkgs.intel-media-driver
  ];

  system = {
    switch.enable = true;
    copySystemConfiguration = false;
    stateVersion = "25.05";
  };

}
