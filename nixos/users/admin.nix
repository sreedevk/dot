{ configs, pkgs, secrets, ... }:
{
  imports = [ ./shared ];

  programs.zsh = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host sree.dev
        HostName sree.dev
        User deploy
        IdentityFile ~/.ssh/devtechnica

      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes

      Host gitlab.com
        HostName gitlab.com
        User git
        IdentityFile ~/.ssh/devtechnica
        IdentitiesOnly yes
    '';
  };

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
      cava
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
