{ configs, pkgs, ... }:

{
  home.username = "admin";
  home.homeDirectory = "/home/admin";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    amfora
    antibody
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
    taskwarrior
    taskwarrior-tui
    tmux
    tokei
    xh
    xxd
    yt-dlp
    zoxide
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "sreedev";
    userEmail = "sreedevpadmakumar@gmail.com";
    signing = {
      key = "F2D006638E49CD45";
      signByDefault = true;
    };

    extraConfig = {
      core = {
        editor = "nvim";
        whitespace = "trailing-space,space-before-tab";
      };

      commit.gpgsign = "true";

      init = {
        defaultBranch = "main";
      };

      color = {
        branch = "auto";
        diff = "auto";
        interactive = "auto";
        status = "auto";
        ui = "true";
      };
    };

    lfs.enable = true;
    attributes = [
      "*.rb diff=ruby"
      "*.rake diff=ruby"
      "*.gemspec diff=ruby"
      "* whitespace=!indent,trail,space"
      "*.[ch] whitespace=indent,trail,space diff=cpp"
      "*.sh whitespace=indent,trail,space eol=lf"
      "*.perl eol=lf diff=perl"
      "*.pl eof=lf diff=perl"
      "*.pm eol=lf diff=perl"
      "*.py eol=lf diff=python"
      "*.bat eol=crlf"
      "/Documentation/**/*.txt eol=lf"
      "/command-list.txt eol=lf"
      "/GIT-VERSION-GEN eol=lf"
      "/mergetools/* eol=lf"
      "/t/oid-info/* eol=lf"
      "/Documentation/git-merge.txt conflict-marker-size=32"
      "/Documentation/gitk.txt conflict-marker-size=32"
      "/Documentation/user-manual.txt conflict-marker-size=32"
      "/t/t????-*.sh conflict-marker-size=32"
    ];
    aliases = {
      a = "add";
      ap = "add --patch";
      br = "branch";
      ca = "commit --amend";
      cb = "checkout -b";
      cl = "clone --recursive -j8";
      cm = "commit -m";
      co = "checkout";
      cp = "cherry-pick";
      dfs = "diff --staged";
      df = "diff";
      fucked = "reset --hard";
      l = "log";
      lg = "log --decorate --oneline --graph";
      s = "status";
      st = "status";
      wta = "worktree add";
      wtr = "worktree remove";
    };
    delta = {
      enable = true;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
  };
}
