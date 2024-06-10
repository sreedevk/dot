{ config, lib, pkgs, secrets, ... }: {
  imports = [ ./adguard.nix ./mullvad.nix ./firewall.nix ];
}
