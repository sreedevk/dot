{ pkgs, inputs, ... }:
let
  language_servers = with pkgs; [
    clojure-lsp
    docker-compose-language-service
    dockerfile-language-server-nodejs
    elixir-ls
    fennel-ls
    lua-language-server
    nil
    nodePackages.vscode-json-languageserver
    rust-analyzer
    tailwindcss-language-server
    taplo
    typescript-language-server
    yaml-language-server
  ];

  neovim_pkgs =
    with pkgs; [
      nodejs_22
      tree-sitter
    ];
in
{
  home.packages = builtins.concatLists [
    language_servers
    neovim_pkgs
  ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  xdg.desktopEntries = {
    neovim = {
      name = "Neovim";
      genericName = "Text Editor";
      exec = "nvim %F";
      comment = "Text Editor";
      mimeType = [
        "text/plain"
        "text/html"
      ];
      terminal = false;
      type = "Application";
    };
  };

}
