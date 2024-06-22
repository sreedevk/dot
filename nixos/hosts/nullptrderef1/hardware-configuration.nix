{ config, lib, pkgs, modulesPath, secrets, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {

    supportedFilesystems = [ "zfs" ];
    extraModulePackages = [ ];
    zfs = {
      forceImportRoot = false;
      forceImportAll = false;
      extraPools = [ "dpool0" ];
    };

    initrd = {
      kernelModules = [ "kvm-intel" ];
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "usb_storage" "sd_mod" ];
    };

  };

  # NOTE: OpenZFS Does not support swap on zvols or datasets
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 128 * 1024;
      randomEncryption.enable = true;
    }
  ];

  fileSystems =
    let
      zfs_mountpoints = secrets.system.mountpoints;
      sys_mountpoints = {
        "/boot" = { device = "/dev/disk/by-uuid/0B7B-5F96"; fsType = "vfat"; };
        "/" = { device = "/dev/disk/by-uuid/66773c39-ea86-4b86-ae8b-31a4e56bf46b"; fsType = "ext4"; };
      };

      mkzfsmount = mountpoint: {
        name = mountpoint.path;
        value = {
          device = mountpoint.device;
          fsType = "zfs";
        };
      };

      mkzfsmounts = mountpoints: builtins.map mkzfsmount mountpoints;
    in
    sys_mountpoints // builtins.listToAttrs (mkzfsmounts zfs_mountpoints);

  networking = {
    useDHCP = lib.mkDefault false;
    hostId = "0ec79991";
    interfaces = {
      enp2s0 = {
        useDHCP = lib.mkDefault false;
        ipv4 = {
          addresses = [{
            address = "192.168.1.179";
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
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
