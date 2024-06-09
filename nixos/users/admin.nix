{ configs, pkgs, ... }:
{
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

  home.file = {
    ".zshrc" = {
      enable = true;
      executable = false;
      recursive = false;
      source = ../../stowed/.zshrc;
    };
    ".zsh" = {
      enable = true;
      source = ../../stowed/.zsh;
      recursive = true;
    };
    ".config" = {
      enable = true;
      source = ../../stowed/.config;
      recursive = true;
    };
    ".local" = {
      enable = true;
      source = ../../stowed/.local;
      recursive = true;
    };
    ".bashrc" = {
      enable = true;
      source = ../../stowed/.bashrc;
      recursive = true;
    };
    ".gitattributes" = {
      enable = true;
      source = ../../stowed/.gitattributes;
      recursive = true;
    };
    ".gitconfig" = {
      enable = true;
      source = ../../stowed/.gitconfig;
      recursive = true;
    };
    ".gitignore" = {
      enable = true;
      source = ../../stowed/.gitignore;
      recursive = true;
    };
    ".taskrc" = {
      enable = true;
      source = ../../stowed/.taskrc;
      recursive = true;
    };
    ".tmux.conf" = {
      enable = true;
      source = ../../stowed/.tmux.conf;
      recursive = true;
    };
    ".profile" = {
      enable = true;
      source = ../../stowed/.profile;
      recursive = true;
    };
    ".vimrc" = {
      enable = true;
      source = ../../stowed/.vimrc;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
}
