{ pkgs
, lib
, config
, ...
}:
{
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrapOffload pkgs.kitty;
    settings = import ./settings.nix { inherit config lib; };
    themeFile = "SpaceGray_Eighties";
    keybindings = import ./keybindings.nix;
  };

  xdg.desktopEntries = {
    kitty = {
      name = "Kitty";
      type = "Application";
      settings = {
        Keywords = "terminal;tty;pty";
      };
      genericName = "Terminal";
      comment = "A terminal emulator";
      exec = "kitty";
      icon = "kitty";
      terminal = false;
      categories = [
        "System"
        "TerminalEmulator"
      ];
    };
  };
}
