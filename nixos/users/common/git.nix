{ pkgs, opts, ... }: {

  home.file = {
    ".gitattributes" = {
      enable = true;
      target = ".gitattributes";
      recursive = true;
      text = ''
        *.rb diff=ruby
        *.rake diff=ruby
        *.gemspec diff=ruby
        * whitespace=!indent,trail,space
        *.[ch] whitespace=indent,trail,space diff=cpp
        *.sh whitespace=indent,trail,space eol=lf
        *.perl eol=lf diff=perl
        *.pl eof=lf diff=perl
        *.pm eol=lf diff=perl
        *.py eol=lf diff=python
        *.bat eol=crlf
        /Documentation/**/*.txt eol=lf
        /command-list.txt eol=lf
        /GIT-VERSION-GEN eol=lf
        /mergetools/* eol=lf
        /t/oid-info/* eol=lf
        /Documentation/git-merge.txt conflict-marker-size=32
        /Documentation/gitk.txt conflict-marker-size=32
        /Documentation/user-manual.txt conflict-marker-size=32
        /t/t????-*.sh conflict-marker-size=32
      '';
    };

    ".gitignore" = {
      enable = true;
      target = ".gitignore";
      recursive = true;
      text = ''
        .tmux/plugins/**
        !.tmux/plugins/tpm
        .customacs.d/elpa/**
      '';
    };

    ".gitconfig" = {
      enable = true;
      target = ".gitconfig";
      recursive = true;
      text = ''
        [user]
          email = sreedevpadmakumar@gmail.com
          name = sreedev
          signingkey = F2D006638E49CD45
        [core]
          attributesfile = ~/.gitattributes
          editor = ${pkgs.neovim}/bin/nvim
          pager = ${pkgs.delta}/bin/delta
        [commit]
          gpgsign = true
        [init]
          defaultBranch = main
        [color]
          branch = auto
          diff = auto
          interactive = auto
          status = auto
          ui = true
        [alias]
          a      = add
          ap     = add --patch
          br     = branch
          ca     = commit --amend
          cb     = checkout -b
          cl     = clone --recursive -j8
          cm     = commit -m
          co     = checkout
          cp     = cherry-pick
          df     = diff
          dfs    = diff --staged
          fucked = reset --hard
          l      = log
          lg     = log --decorate --oneline --graph
          s      = status
          st     = status
          wta    = worktree add
          wtr    = worktree remove
        [rerere]
          enabled = false
        [advice]
          detachedHead = false
        [filter "lfs"]
          clean = git-lfs clean -- %f
          smudge = git-lfs smudge -- %f
          process = git-lfs filter-process
          required = true
        [interactive]
          diffFilter = delta --color-only
        [add.interactive]
          useBuiltin = false # required for git 2.37.0
        [delta]
            navigate = true
            light = false
            features = side-by-side line-numbers decorations
            syntax-theme = Dracula
            plus-style = syntax "#003800"
            minus-style = syntax "#3f0001"
            zero-style = dim syntax
        [delta "decorations"]
            commit-decoration-style = bold yellow box ul
            commit-style = raw
            file-style = omit
            file-decoration-style = none
            hunk-header-decoration-style = blue box
            hunk-header-file-style = red
            hunk-header-line-number-style = "#067a00"
            hunk-header-style = file line-number syntax
        [merge]
            conflictstyle = diff3
        [diff]
            colorMoved = default
        [safe]
        	directory = /etc/nixos
      '';
    };
  };

}
