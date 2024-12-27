{ pkgs, username, ... }:
let
  language_servers =
    with pkgs; [
      glas # gleam
    ];

  neovim_pkgs =
    with pkgs; [
      neovim
      nodejs_22
      tree-sitter
    ];
in
{
  home.packages = builtins.concatLists [
    language_servers
    neovim_pkgs
  ];

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
