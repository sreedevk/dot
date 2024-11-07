{ pkgs, config, opts, ... }:
{
  import = [
    ./animations.nix
    ./cursor.nix
    ./decorations.nix
    ./devices.nix
    ./envs.nix
    ./execs.nix
    ./extra.nix
    ./general.nix
    ./inputs.nix
    ./keybinds.nix
    ./monitors.nix
    ./rules.nix
  ];
}
