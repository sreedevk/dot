{ config, pkgs, secrets, system, inputs, ... }:
let
  opts =
    { paths = { encAppData = "/mnt/enc_data_drive/AppData"; }; };
in
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
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
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
    domain = "nullptrderef1";
    search = [ "nullptrderef1" ];
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
      insertNameservers =
        [ "127.0.0.1" "149.112.112.112" "194.242.2.5" "9.9.9.9" ];
    };
    nameservers = pkgs.lib.mkForce [
      "127.0.0.1"
      "149.112.112.112"
      "194.242.2.5"
      "9.9.9.9"
    ];
    enableIPv6 = false;
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
  };

  systemd.services.radio-streaming = {
    description = "enable audio streaming from XHDATA D-328 Radio";
    enable = true;
    after = [ "network.target" ];
    wants = [ "network.target" ];
    serviceConfig = {
      ExecStart =
        "${pkgs.ffmpeg}/bin/ffmpeg -f alsa -ac 2 -ar 44100 -i hw:0 -acodec libmp3lame -b:a 128k -content_type audio/mpeg -f mp3 icecast://radiosource:${secrets.icecast.password}@localhost:8099/radio";
      Restart = "always";
    };
  };

  systemd.services.taskchampion-sync = {
    description = "taskwarrior task server";
    enable = true;
    after = [ "network.target" ];
    wants = [ "network.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.taskchampion-sync-server}/bin/taskchampion-sync-server --port 8080 --data-dir ${opts.paths.encAppData}/TaskChampion
      '';
      Restart = "always";
    };
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
    packages = with pkgs; [ iosevka nerdfonts ];
    fontconfig = { enable = true; };
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
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
    icecast
    iwd
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
    pciutils
    sshfs
    strace
    taskchampion-sync-server
    traceroute
    unzip
    zip
    zfs
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

    icecast = {
      enable = true;
      hostname = "nullptrderef1";
      listen = {
        address = "0.0.0.0";
        port = 8099;
      };
      admin = {
        user = "admin";
        password = secrets.icecast.password;
      };
      extraConf = ''
        <authentication>
           <source-password>${secrets.icecast.password}</source-password>
           <relay-user>relay</relay-user>
           <relay-password>${secrets.icecast.password}</relay-password>
           <admin-user>admin</admin-user>
           <admin-password>${secrets.icecast.password}</admin-password>
        </authentication>
        <mount type="normal">
          <mount-name>/radio</mount-name>
          <username>radiosource</username>
          <password>${secrets.icecast.password}</password>
          <dump-file>/tmp/dump-example1.ogg</dump-file>
          <stream-name>New York City Radio Stream</stream-name>
        </mount>
      '';
    };

    cockpit = {
      enable = true;
      port = 8008;
      openFirewall = true;
      settings = { WebService = { AllowUnencrypted = true; }; };
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

