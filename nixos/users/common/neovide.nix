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
        fork = true
        wsl = false
        no-multigrid = false
        vsync = true
        maximized = false
        srgb = true
        idle = true
        neovim-bin = "${pkgs.neovim}/bin/nvim"
        frame = "full"
      '';
    };
  };

  home.packages = [
    nvidiaNeovide
  ];
}
