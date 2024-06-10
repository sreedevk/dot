{ configs, pkgs, secrets, ... }:
{
  imports = [ ./shared ];
  home = {
    username = "admin";
    homeDirectory = "/home/admin";
    stateVersion = "23.11";
    packages = with pkgs; [
      asdf-vm
      babashka
      dig
      delta
      gh
      glab
      neovim
      newsboat
      ruby
      tmux
      tmuxPlugins.extrakto
      tmuxPlugins.jump
      tmuxPlugins.tmux-thumbs
      tmuxPlugins.yank
    ];
  };
}
