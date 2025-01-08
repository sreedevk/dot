{ pkgs, lib, config, ... }:
let
  nixglmod = import ../nixGL.nix { inherit lib config pkgs; };
in
{
  stylix.targets.kitty = {
    enable = true;
    variant256Colors = true;
  };

  programs.kitty = {
    enable = true;
    package = nixglmod.nixGLWrapped pkgs.kitty "kitty";
    settings = (import ./settings.nix { inherit config lib; });
    keybindings = (import ./keybindings.nix);
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
