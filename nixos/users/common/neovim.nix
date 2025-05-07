{ pkgs, config, ... }:
let
  language_servers = with pkgs; [
    clojure-lsp
    docker-compose-language-service
    dockerfile-language-server-nodejs
    elixir-ls
    fennel-ls
    lua-language-server
    marksman
    nil
    nodePackages.vscode-json-languageserver
    rust-analyzer
    tailwindcss-language-server
    taplo
    tinymist
    typescript-language-server
    typstfmt
    yaml-language-server
  ];

  neovim_pkgs =
    with pkgs; [
      nodejs_24
      tree-sitter
      typst
    ];
in
{
  home.packages = builtins.concatLists [
    language_servers
    neovim_pkgs
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
      categories = [ "GTK" "Development" "IDE" "TextEditor" ];
      type = "Application";
    };
  };

}
