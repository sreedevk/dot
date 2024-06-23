{ config, lib, pkgs, secrets, opts, ... }: {
  imports = [
    ./adguard.nix
    ./mullvad.nix
    ./firewall.nix
    ./icecast.nix
    ./telemetry.nix
    ./taskchampion.nix
  ];
}
