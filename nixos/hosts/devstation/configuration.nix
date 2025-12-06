{ pkgs, opts, ... }:
{
  config = {
    system-manager.allowAnyDistro = true;
    nixpkgs.hostPlatform = "x86_64-linux";

    environment.systemPackages = [
      pkgs.ripgrep
      pkgs.fd
    ];

    nix = {
      package = pkgs.nixVersions.stable;
      settings = {

        allowed-users = [
          "sreedev"
          "edge"
        ];
        download-buffer-size = 4000000000;
        fallback = true;
        auto-optimise-store = true;
        http2 = false;
        show-trace = true;
        trusted-users = [
          "sreedev"
          "edge"
        ];
        warn-dirty = true;

        experimental-features = [
          "nix-command"
          "flakes"
          "recursive-nix"
        ];

        substituters = [
          "https://attic.nullptr.sh/devstation"
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
          "devstation:FB1QNgS2s/Guv4hZvFMevbbP6ABvsOMygQbBeKnHf4E="
          "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
          "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        ];

        trusted-substituters = [
          "https://attic.nullptr.sh/devstation"
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
          "https://cuda-maintainers.cachix.org"
          "https://numtide.cachix.org"
          "https://colmena.cachix.org"
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
      "resolvconf.conf" = {
        text = ''
          name_server_blacklist="127.0.0.1"
          resolv_conf=/etc/resolv.conf
          name_servers="${opts.addresses.tailscale.apollo} 149.112.112.112 9.9.9.9 149.112.112.112 1.1.1.1 1.0.0.1 2620:fe::fe 2620:fe::9"
          resolv_conf_options="timeout:0 attempts:1 rotate"
        '';
      };
    };
  };
}
