{ config, lib, pkgs, modulesPath, opts, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {

    kernelParams =
      let
        force_sync_at_x_dirty_gb = 6;
        hung_task_timeout_secs = 800;
        zfs_arc_max_gb = 25;
        zfs_dirty_data_max_gb = 6;
      in
      [
        "hung_task_timeout_secs=${builtins.toString hung_task_timeout_secs}"
        "nohibernate"
        "zfs.zfs_arc_max=${builtins.toString (zfs_arc_max_gb * 1073741824)}"
        "zfs.zfs_dirty_data_max=${builtins.toString (zfs_dirty_data_max_gb * 1073741824)}"
        "zfs.zfs_dirty_data_sync=${builtins.toString (force_sync_at_x_dirty_gb * 1073741824) }"
      ];

    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "1048576";
      "vm.swappiness" = 70;
      "vm.dirty_ratio" = 20;
      "vm.dirty_background_ratio" = 10;
    };

    supportedFilesystems = [ "zfs" ];
    extraModulePackages = [ ];
    zfs = {
      forceImportRoot = false;
      forceImportAll = false;
      extraPools = [ "dpool0" "dpool1" ];
    };

    initrd = {
      kernelModules = [ "kvm-intel" ];
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "usb_storage" "sd_mod" ];
    };

  };

  services.smartd = {
    enable = true;
    autodetect = false;
    devices = [
      { device = "/dev/disk/by-id/usb-ST8000DM_004-2U9188_0000000000000002-0:0"; }
      { device = "/dev/disk/by-id/usb-ST8000DM_004-2U9188_0000000000000001-0:0"; }
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 128 * 1024;
      randomEncryption.enable = true;
    }
  ];

  fileSystems =
    let
      mkzfsmount = mountpoint: {
        name = mountpoint.path;
        value = {
          device = mountpoint.device;
          fsType = "zfs";
          options = [ "noatime" ];
        };
      };

      sys_mountpoints = {
        "/boot" = {
          device = "/dev/disk/by-uuid/336E-023D";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };
        "/" = {
          device = "/dev/disk/by-uuid/db18f4e1-9c29-41da-a57a-2c2a9d405cd8";
          fsType = "ext4";
        };
      };

      zfs_mountpoints = builtins.listToAttrs (builtins.map mkzfsmount opts.mountpoints);
    in
    sys_mountpoints // zfs_mountpoints;

  networking = {
    useDHCP = lib.mkDefault false;
    hostId = "0ec79991";
    interfaces = {
      enp2s0 = {
        useDHCP = lib.mkDefault false;
        ipv4 = {
          addresses = [{
            address = opts.lanAddress;
            prefixLength = 24;
          }];
        };
      };
      wlan0 = {
        useDHCP = lib.mkDefault true;
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
