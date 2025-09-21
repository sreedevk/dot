{ pkgs, config, ... }:
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
        neovim-bin = "${config.programs.neovim.package}/bin/nvim"
        frame = "full"
      '';
    };
  };

  home.packages = [
    (config.lib.nixGL.wrap pkgs.neovide)
  ];
}
