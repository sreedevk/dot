{ pkgs, lib, config, ... }:
let
  nixglmod = import ./nixGL.nix { inherit lib config pkgs; };
  nvidiaNeovide = nixglmod.nixGLWrapped pkgs.neovide "neovide";
in
{

  home.file = {
    "neovide/config.toml" = {
      enable = true;
      recursive = false;
      executable = false;
      target = ".config/neovide/config.toml";
      text = ''
        wsl = false
        no-multigrid = true
        vsync = true
        maximized = false
        srgb = true
        idle = false
        neovim-bin = "${pkgs.neovim}/bin/nvim" # found dynamically on $PATH if unset
        frame = "full"
      '';
    };
  };

  home.packages = [
    nvidiaNeovide
  ];
}
