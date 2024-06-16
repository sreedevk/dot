{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.zfs.forceImportRoot = false;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/66773c39-ea86-4b86-ae8b-31a4e56bf46b";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0B7B-5F96";
    fsType = "vfat";
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/8691d951-a1f4-4702-a947-e91e6afc4614";
    fsType = "ext4";
  };

  fileSystems."/mnt/enc_data_drive" = {
    device = "/dev/disk/by-uuid/af7977f8-c99e-4b48-8a25-dc716233bfd5";
    fsType = "ext4";
  };

  fileSystems."/mnt/media" =
    { device = "datapool/media";
      fsType = "zfs";
    };

  boot.initrd.luks.devices."enc_data_drive".device =
    "/dev/disk/by-uuid/2123e639-909b-44ac-ac4a-6c896746d33f";

  boot.zfs.extraPools = [ "datapool" ];

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault false;
  networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  networking.interfaces.wlan0.useDHCP = lib.mkDefault true;
  networking.hostId = "0ec79991";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
