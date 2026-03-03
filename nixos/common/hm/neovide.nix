{ pkgs, config, ... }:
{
  programs.neovide = {
    enable = true;
    package = config.lib.nixGL.wrapOffload pkgs.neovide;
    settings = {
      fork = true;
      wsl = false;
      no-multigrid = false;
      vsync = true;
      maximized = false;
      srgb = true;
      idle = true;
      neovim-bin = "${config.programs.neovim.package}/bin/nvim";
      frame = "full";
    };
  };
}
