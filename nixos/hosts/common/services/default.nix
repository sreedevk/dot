{ config, lib, pkgs, opts, ... }: {
  imports = [
    ./adguard.nix
    ./mullvad.nix
    ./taskchampion.nix
    ./clamav.nix
    ./zrepl.nix
  ];
}
