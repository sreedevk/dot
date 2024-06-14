{ pkgs, secrets, username, ... }: {
  home.packages = with pkgs; [
    neovim
    nodejs-slim
  ];
}
