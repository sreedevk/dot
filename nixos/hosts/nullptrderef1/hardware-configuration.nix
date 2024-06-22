{ config, lib, pkgs, modulesPath, secrets, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {

    supportedFilesystems = [ "zfs" ];
    extraModulePackages = [ ];
    zfs = {
      forceImportRoot = false;
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


  fileSystems = {
    # NOTE: CORE OS PARTITIONS
    "/boot" = { device = "/dev/disk/by-uuid/0B7B-5F96"; fsType = "vfat"; };
    "/" = { device = "/dev/disk/by-uuid/66773c39-ea86-4b86-ae8b-31a4e56bf46b"; fsType = "ext4"; };

    # NOTE: DATA PARTITIONS
    "/mnt/dpool0/media" = { device = "dpool0/media"; fsType = "zfs"; };
    "/mnt/dpool0/media/videos" = { device = "dpool0/media/videos"; fsType = "zfs"; };
    "/mnt/dpool0/media/movies" = { device = "dpool0/media/movies"; fsType = "zfs"; };
    "/mnt/dpool0/media/music" = { device = "dpool0/media/music"; fsType = "zfs"; };
    "/mnt/dpool0/media/photos" = { device = "dpool0/media/photos"; fsType = "zfs"; };
    "/mnt/dpool0/media/shows" = { device = "dpool0/media/shows"; fsType = "zfs"; };
    "/mnt/dpool0/other" = { device = "dpool0/other"; fsType = "zfs"; };
    "/mnt/dpool0/secrets" = { device = "dpool0/secrets"; fsType = "zfs"; };
    "/mnt/dpool0/notes" = { device = "dpool0/notes"; fsType = "zfs"; };
    "/mnt/dpool0/appdata" = { device = "dpool0/appdata"; fsType = "zfs"; };
    "/mnt/dpool0/backups" = { device = "dpool0/backups"; fsType = "zfs"; };
    "/mnt/dpool0/resources" = { device = "dpool0/resources"; fsType = "zfs"; };
    "/mnt/dpool0/resources/llms" = { device = "dpool0/resources/llms"; fsType = "zfs"; };
    "/mnt/dpool0/resources/databases" = { device = "dpool0/resources/databases"; fsType = "zfs"; };
    "/mnt/dpool0/resources/wordlists" = { device = "dpool0/resources/wordlists"; fsType = "zfs"; };
    "/mnt/dpool0/resources/other" = { device = "dpool0/resources/other"; fsType = "zfs"; };
    "/mnt/dpool0/personal" = { device = "dpool0/personal"; fsType = "zfs"; };
    "/mnt/dpool0/personal/documents" = { device = "dpool0/personal/documents"; fsType = "zfs"; };
    "/mnt/dpool0/personal/finances" = { device = "dpool0/personal/finances"; fsType = "zfs"; };
    "/mnt/dpool0/personal/projects" = { device = "dpool0/personal/projects"; fsType = "zfs"; };
    "/mnt/dpool0/personal/archives" = { device = "dpool0/personal/archives"; fsType = "zfs"; };
    "/mnt/dpool0/personal/other" = { device = "dpool0/personal/other"; fsType = "zfs"; };
    "/mnt/dpool0/media/magazines" = { device = "dpool0/media/magazines"; fsType = "zfs"; };
    "/mnt/dpool0/media/audiobooks" = { device = "dpool0/media/audiobooks"; fsType = "zfs"; };
    "/mnt/dpool0/media/books" = { device = "dpool0/media/books"; fsType = "zfs"; };
    "/mnt/dpool0/downloads" = { device = "dpool0/downloads"; fsType = "zfs"; };
    "/mnt/dpool0/downloads/torrents" = { device = "dpool0/downloads/torrents"; fsType = "zfs"; };
    "/mnt/dpool0/media/audio" = { device = "dpool0/media/audio"; fsType = "zfs"; };
  };

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
