{ pkgs, ... }:
{

  imports = [
    ./settings.nix
    ./keybindings.nix
  ];

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    quickAccessTerminalConfig = {
      start_as_hidden = false;
      hide_on_focus_loss = false;
      background_opacity = 0.75;
      grab_keyboard = false;
    };
    themeFile = "rose-pine";
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
