{ pkgs, nixpkgs-stable, username, ... }: {
  home.packages =
    let
      stable-packages = with nixpkgs-stable; [
        tailspin
      ];
      unstable-packages =
        with pkgs; [
          aspell
          aspellDicts.en
          aspellDicts.en-computers
          aspellDicts.en-science
          bat
          bingrep
          broot
          dig
          direnv
          duf
          dust
          exiftool
          eza
          fd
          fzf
          git
          git-crypt
          git-filter-repo
          git-sizer
          gitleaks
          gperf
          grex
          hex
          html-tidy
          httpie
          hyperfine
          id3v2
          imagemagick
          ipcalc
          jaq
          jq
          less
          lua
          lua52Packages.lpeg
          luau
          mediainfo
          miller
          mosh
          nasm
          netcat-gnu
          nettools
          nix-prefetch-git
          nmap
          ouch
          p7zip
          pass
          procs
          progress
          pwgen
          python311Packages.eyed3
          restic
          ripgrep
          ripgrep-all
          rsync
          sc-im
          sshfs
          starship
          tokei
          traceroute
          tree
          tty-clock
          uiua
          unrar
          wget
          xh
          xxd
          yazi
          yq
          zellij
          zoxide
        ];
    in
    stable-packages ++ unstable-packages;
}
