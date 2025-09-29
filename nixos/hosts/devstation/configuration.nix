{ pkgs
, lib
, opts
, ...
}:
{
  options = with lib; {
    system-manager = {
      allowAnyDistro = mkOption {
        type = types.bool;
        default = false;
        description = "allow system-manager to run on any distro";
      };
    };
  };
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
        allowed-users = [ "sreedev" ];
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "recursive-nix"
        ];
        http2 = false;
        show-trace = true;
        substituters = [ "https://cache.nixos.org/" ];
        trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
        trusted-substituters = [ "https://cache.nixos.org/" ];
        trusted-users = [ "sreedev" ];
        warn-dirty = true;
      };
    };

    environment.etc = {
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
