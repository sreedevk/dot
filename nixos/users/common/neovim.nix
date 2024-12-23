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
}
