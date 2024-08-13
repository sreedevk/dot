{ config, lib, pkgs, secrets, opts, ... }: {
  imports = [
    ./adguard.nix
    ./mullvad.nix
    ./icecast.nix
    ./taskchampion.nix
    ./clamav.nix
  ];
}
