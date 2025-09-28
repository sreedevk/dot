{ pkgs
, opts
, ...
}:
{
  config = {

    system-manager.allowAnyDistro = true;
    nixpkgs.hostPlatform = "x86_64-linux";
    environment.systemPackages = [
      pkgs.ripgrep
      pkgs.fd
      pkgs.hello
    ];
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
