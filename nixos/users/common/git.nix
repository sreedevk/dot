{ pkgs
, opts
, config
, ...
}:
let
  gpgsign = if opts.git.enable-signing then "true" else "false";
in
{
  home.packages = with pkgs; [
    git
    git-cliff
    git-crypt
    git-filter-repo
    git-sizer
    gitleaks
  ];

  programs.git = {
    enable = true;
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
      df = "diff";
      dfs = "diff --staged";
      fucked = "reset --hard";
      l = "log";
      lg = "log --decorate --oneline --graph -n 20";
      lgc = "log --decorate --oneline --graph -n 20 --no-abbrev";
      pl = "pull";
      ps = "push";
      rb = "rebase";
      s = "status";
      st = "status";
      wt = "worktree";
      wta = "worktree add";
      wtr = "worktree remove";
    };
    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
        features = "side-by-side line-numbers decorations";
        syntax-theme = "Dracula";
        plus-style = "syntax \"#003800\"";
        minus-style = "syntax \"#3f0001\"";
        zero-style = "dim syntax";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          commit-style = "raw";
          file-style = "omit";
          file-decoration-style = "none";
          hunk-header-decoration-style = "blue box";
          hunk-header-file-style = "red";
          hunk-header-line-number-style = "#067a00";
          hunk-header-style = "file line-number syntax";
        };
      };
    };
    extraConfig = {
      user = {
        email = "sreedev@icloud.com";
        name = "sreedevk";
        signingkey = "B8C402B16E80E17C";
      };
      core = {
        attributesfile = "~/.gitattributes";
        bare = false;
        editor = "${config.programs.neovim.package}/bin/nvim";
        filemode = true;
        ignorecase = true;
        logallrefupdates = true;
        pager = "${pkgs.delta}/bin/delta";
        precomposeunicode = true;
        repositoryformatversion = 0;
      };
      commit = {
        inherit gpgsign;
      };
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
      rerere = {
        enabled = "false";
      };
      fetch = {
        prune = "true";
      };
      advice = {
        detachedHead = "false";
      };
      filter = {
        lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = "true";
        };
      };
      interactive = {
        diffFilter = "${pkgs.delta}/bin/delta --color-only";
      };
      "add.interactive" = {
        useBuiltin = "false"; # required for git 2.37.0
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      safe = {
        directory = "/etc/nixos";
      };
    };
    ignores = [
      ".tmux/plugins/**"
      "!.tmux/plugins/tpm"
      ".customacs.d/elpa/**"
    ];
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
  };
}
