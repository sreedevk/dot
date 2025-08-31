{ ... }:
{
  imports = [
    ./adguard.nix
    ./unbound.nix
    ./mullvad.nix
    ./taskchampion.nix
    ./clamav.nix
    ./zrepl.nix
  ];
}
