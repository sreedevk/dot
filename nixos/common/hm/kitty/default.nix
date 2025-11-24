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
    quickAccessTerminalConfig = {
      start_as_hidden = false;
      hide_on_focus_loss = false;
      background_opacity = 0.85;
      grab_keyboard = false;
    };
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
