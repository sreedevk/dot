{ pkgs, lib, config, ... }:
let
  themes = import ../themes.nix;
in
{
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.kitty;
    settings = themes.zitchdog-pine // (import ./settings.nix { inherit config lib; });
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
      categories = [ "System" "TerminalEmulator" ];
    };
  };
}
