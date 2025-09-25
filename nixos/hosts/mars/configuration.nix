{ config
, pkgs
, opts
, modulesPath
, ...
}:
{
  imports = [
    "${modulesPath}/virtualisation/incus-virtual-machine.nix"
  ];

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
    hostName = "mars";
  };

  users.users.admin = {
    isNormalUser = true;
    linger = true;
    shell = pkgs.zsh;
    description = "system root user & administrator";
    hashedPasswordFile = config.age.secrets.nullptrderef1_admin_password.path;
    openssh.authorizedKeys.keys = with opts.publicKeys; [
      apollo
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
  systemd.network = {
    enable = true;
    networks."50-enp5s0" = {
      matchConfig.Name = "enp5s0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  system.stateVersion = "25.11";
}
