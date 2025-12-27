{ pkgs, config, ... }:
let
  formatters = with pkgs; [
    typstyle # typst
    elmPackages.elm-format # elm
    dockfmt # Dockerfile
  ];

  language_servers = with pkgs; [
    akkuPackages.scheme-langserver  # scheme-langserver
    astro-language-server           # astro
    clojure-lsp                     # clojure
    elixir-ls                       # elixir
    elmPackages.elm-language-server # elm
    fennel-ls                       # fennel
    jsonnet-language-server         # jsonnet
    ltex-ls-plus                    # grammar
    lua-language-server             # lua
    marksman                        # markdown
    nil                             # nix
    taplo                           # toml
    tinymist                        # typst
    vscode-langservers-extracted    # json+
    yaml-language-server            # yaml
    zls                             # zig
  ];

  neovim_pkgs = with pkgs; [
    nodejs-slim
    tree-sitter
    typst
  ];
in
{
  home.packages = builtins.concatLists [
    language_servers
    neovim_pkgs
    formatters
  ];

  programs.neovim = {
    enable = true;
  };

  xdg.desktopEntries = {
    neovim = {
      name = "NeoVim";
      icon = "nvim";
      genericName = "Text Editor";
      exec = "${config.programs.alacritty.package}/bin/alacritty -e ${config.programs.neovim.package}/bin/nvim %F";
      comment = "Text Editor";
      mimeType = [
        "text/plain"
        "text/html"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-java"
        "text/x-dsrc"
        "text/x-pascal"
        "text/x-perl"
        "text/x-python"
        "application/x-php"
        "application/x-httpd-php3"
        "application/x-httpd-php4"
        "application/x-httpd-php5"
        "application/xml"
        "text/html"
        "text/css"
        "text/x-sql"
        "text/x-diff"
      ];
      terminal = false;
      categories = [
        "GTK"
        "Development"
        "IDE"
        "TextEditor"
      ];
      type = "Application";
    };
  };

}
