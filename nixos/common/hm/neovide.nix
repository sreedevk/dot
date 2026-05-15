{ pkgs, config, ... }:
{
  programs.neovide = {
    enable = true;
    package = pkgs.neovide;
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
