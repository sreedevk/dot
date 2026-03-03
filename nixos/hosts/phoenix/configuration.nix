{ pkgs
, opts
, config
, ...
}:
{
  config = {
    system-manager.allowAnyDistro = true;
    nixpkgs.hostPlatform = "x86_64-linux";

    environment.systemPackages = with pkgs; [
      fastfetch
      fd
      ripgrep
    ];

    # BUG: system-manager above v1.0 will fail if this is not here;
    # services.userborn.enable = pkgs.lib.mkForce false;

    # FIX: TEMPORARY SOLUTION TO HANDLE USERBORN KICKING nixbld USERS OUT OF nixbld GROUP
    users = {
      groups = {
        audio.gid = 995;
        bluetooth.gid = 30001;
        docker.gid = 967;
        incus-admin.gid = 965;
        incus.gid = 966;
        libvirt.gid = 963;
        nixbld.gid = 30000;
        realtime.gid = 962;
        render.gid = 987;
        video.gid = 983;
        wheel.gid = 998;
      };
      users = {
        nixbld1 = {
          uid = 30001;
          group = "nixbld";
          isSystemUser = true;
          enable = true;
        };
        root.shell = "/bin/bash";
        sreedev = {
          uid = 1000;
          group = "sreedev";
          enable = true;
          isNormalUser = true;
          linger = true;
          shell = pkgs.zsh;
          description = "system root user & administrator";
          hashedPasswordFile = config.age.secrets.phoenix-user-password.path;
          packages = with pkgs; [ neovim ];
          extraGroups = [
            "realtime"
            "libvirt"
            "incus-admin"
            "incus"
            "bluetooth"
            "docker"
            "wheel"
            "audio"
            "video"
            "render"
          ];
          openssh.authorizedKeys.keys = with opts.publicKeys; [
            apollo
            rpi4b
            terminus
            phoenix
          ];
        };
      };
    };

    nix = {
      package = pkgs.nixVersions.stable;
      settings = {

        allowed-users = [
          "sreedev"
        ];
        download-buffer-size = 4000000000;
        fallback = true;
        auto-optimise-store = true;
        http2 = false;
        show-trace = true;
        trusted-users = [
          "sreedev"
        ];
        warn-dirty = true;

        experimental-features = [
          "nix-command"
          "flakes"
          "recursive-nix"
        ];

        substituters = builtins.concatLists [
          (if opts.attic.url != null then [ opts.attic.url ] else [ ])
          [
            "https://cache.nixos.org/"
            "https://cuda-maintainers.cachix.org"
            "https://nix-community.cachix.org"
            "https://numtide.cachix.org"
            "https://colmena.cachix.org"
          ]
        ];

        trusted-public-keys = builtins.concatLists [
          (if opts.attic.key != null then [ opts.attic.key ] else [ ])
          [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "cuda-maintainers.cachix.org-1:Ji+ZysQ8GqEtvQF3o4O5q6c3y8C3b2q9p5g6s7d8e9k="
            "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
            "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
          ]
        ];

        trusted-substituters = builtins.concatLists [
          (if opts.attic.url != null then [ opts.attic.url ] else [ ])
          [
            "https://cache.nixos.org/"
            "https://cuda-maintainers.cachix.org"
            "https://nix-community.cachix.org"
            "https://numtide.cachix.org"
            "https://colmena.cachix.org"
          ]
        ];

      };
    };

    environment.etc = {
      "NetworkManager/conf.d/wifi_backend.conf" = {
        text = ''
          [device]
          wifi.backend=iwd
        '';
      };

      "NetworkManager/conf.d/20-connectivity.conf" = {
        text = ''
          [connectivity]
          enabled=false
        '';
      };

      "systemd/system.conf" = {
        text = ''
          [Manager]
          DefaultTimeoutStopSec=10s
        '';
      };

      "modprobe.d/droidcam.conf" = {
        text = ''
          options v4l2loopback exclusive_caps=1
        '';
      };

      "modules-load.d/droidcam.conf" = {
        text = ''
          v4l2loopback
          snd_aloop
        '';
      };

      "xdg/reflector/reflector.conf" = {
        text = ''
          --save /etc/pacman.d/mirrorlist
          --protocol https
          --country us,fr,de,ca,dk
          --latest 50 
          --score 10 
          --fastest 5 
          --sort rate
          --threads 8 
        '';
      };

      "resolvconf.conf" = {
        text = ''
          name_server_blacklist="127.0.0.1"
          resolv_conf=/etc/resolv.conf
          name_servers="100.100.100.100 149.112.112.112 9.9.9.9 149.112.112.112 1.1.1.1 1.0.0.1 2620:fe::fe 2620:fe::9"
          resolv_conf_options="timeout:0 attempts:1 rotate"
        '';
      };

    };
  };
}
