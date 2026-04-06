{ pkgs, ... }:
{
  home.packages =
    let
      bwfzf            = import (../../../../../../common/hm/scripts/bwfzf.nix)       { inherit pkgs; };
      tmux-sessionizer = import (../../../../../../common/hm/scripts/sessionizer.nix) { inherit pkgs; };
    in
    with pkgs;
    [
      agenix                   # age based nix secrets
      aichat                   # cli multi-modal AI chat frontend
      aria2                    # aria downloader
      asciinema                # terminal recorder
      asciinema-agg            # terminal recorder format converter
      aspell                   # gnu spellchecker
      aspellDicts.en           # aspell english dictionary
      aspellDicts.en-computers # aspell computers dictionary
      aspellDicts.en-science   # aspell science dictionary
      attic-client             # attic self hosted cache client
      browsh                   # Fully-modern text-based browser
      bwfzf                    # bitwarden fzf
      caligula                 # lightweight TUI for disk imaging
      cava                     # audio visualizer
      chuck                    # real-time sound synthesis
      claude-code              # coding agent
      cmatrix                  # matrix
      colmena                  # deployment
      csvkit                   # CSVKit
      csvlens                  # csv tui viewer
      deadnix                  # identify nix dead code
      doxygen                  # source code document generator
      duckdb                   # duck db
      elan                     # lean version manager
      fasm                     # flat assembler
      foremost                 # Recover files based on their contents
      glab                     # gitlab cli
      glances                  # system stats viewer
      glow                     # tui markdown renderer
      goat                     # Go ASCII Tool
      gpg-tui                  # gnupg tui
      gping                    # ping grapher
      graphviz                 # graph visualizer
      gurk-rs                  # signal messenger tui
      helix                    # post-modern modal text editor
      hexyl                    # cli hex viewer
      hledger                  # plain text cli accounting
      hledger-iadd             # hledger interactively add transactions
      hledger-ui               # hledger tui
      hledger-utils            # hledger utils
      hledger-web              # hledger web ui
      hping                    # ping flooding
      html-tidy                # HTML validator
      hyperfine                # benchmarking tool
      imager                   # Interferometric imaging package
      instaloader              # instagram downloader
      ipcalc                   # ip math
      jira-cli-go              # jira
      jiratui                  # jira tui
      jless                    # json pager
      just                     # command runner
      k9s                      # k8s tui
      kubectl                  # k8s
      lazydocker               # docker tui
      ledger                   # cli ledger
      llama-cpp                # llama-cpp
      lm_sensors               # lm_sensors
      mc                       # midnight commander file manager
      mdbook                   # generate books from markdown
      metasploit               # Metasploit Framework - a collection of exploits
      miller                   # awk, sed, cut, join and sort for csv, tsv, json
      nasm                     # x86_64 assembler
      nerd-fonts.iosevka       # iosevka nerd font
      nerd-fonts.iosevka-term  # iosevka term nerd font
      nixfmt                   # nix formatter
      nmap                     # network discovery and security auditing
      nnn                      # n³ The unorthodox terminal file manager
      nushell                  # modern shell written in rust
      orca-c                   # Esoteric prog lang to create procedural sequencers
      pandoc                   # document format converter
      posting                  # modern tui http client
      presenterm               # terminal presentations
      qrencode                 # qr code generator
      radicle-tui              # radicle-tui
      rbw                      # stateful bitwarden cli
      recyclarr                # arr trash guides sync
      s3cmd                    # s3 cli
      sc-im                    # vim like tui spreadsheet
      scdl                     # soundcloud download
      silicon                  # code screenshot generator
      sqlmap                   # Automatic SQL injection and database takeover tool
      statix                   # nix code linter
      streamrip                # tidal / soundcloud / deezer downloader cli
      terminaltexteffects      # cli text effects
      texliveFull              # pandoc supporting packages for pdf/latex
      ticker                   # asset ticker
      timr-tui                 # tui timers
      tmux-sessionizer         # tmux sessionizer
      tmuxinator               # tmuxinator
      toilet                   # fancy large cli text generator
      tokei                    # lines of code count
      tty-clock                # tty clock
      uiua                     # array oriented programming language
      uv                       # python package manager
      visidata                 # terminal multitool for tabular data
      wiremix                  # tui for pipewire audio control
      yt-dlp                   # youtube downloader
    ];
}
