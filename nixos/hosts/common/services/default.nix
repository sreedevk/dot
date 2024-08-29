{ config, lib, pkgs, secrets, opts, ... }: {
  imports = [
    ./adguard.nix
    ./mullvad.nix
    ./taskchampion.nix
    ./clamav.nix
  ];
}
