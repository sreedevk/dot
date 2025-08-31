{ ... }:
{
  boot.isContainer = true;
  system.stateVersion = "24.11";
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/4B48-1137";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-uuid/e12147cc-4a2a-4924-b9c0-3947da1cbe86";
      fsType = "ext4";
    };
  };
}
