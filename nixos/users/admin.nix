{ configs, pkgs, secrets, ... }:
{
  imports = [ ./shared ];
  home = {
    username = "admin";
    homeDirectory = "/home/admin";
    stateVersion = "23.11";
    packages = with pkgs; [
      amfora
      antibody
      asdf-vm
      babashka
      bat
      btop
      delta
      du-dust
      duf
      emacs
      eza
      fastfetch
      fd
      fzf
      gh
      git
      git-crypt
      glab
      glow
      gping
      hexyl
      hledger
      htop
      hyperfine
      ipcalc
      irssi
      jaq
      jq
      lf
      ncdu
      neovim
      newsboat
      procs
      ruby
      stow
      tailspin
      taskwarrior3
      taskwarrior-tui
      tmux
      tmuxPlugins.extrakto
      tmuxPlugins.jump
      tmuxPlugins.tmux-thumbs
      tmuxPlugins.yank
      tmuxinator
      tokei
      vim
      xh
      xxd
      yt-dlp
      zoxide
    ];
  };
}
