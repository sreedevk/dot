{ pkgs, username, ... }: {
  home.packages = with pkgs; [
    neovim
    nodejs-slim
    tree-sitter
  ];
}
