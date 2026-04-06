{ pkgs, ... }:
let
  vimPlug = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/junegunn/vim-plug/34467fc07d1bf1b3a6588e9d62711b9f7a8afda3/plug.vim";
    sha256 = "1c9b8cb3zkkw860w15yylzrvas5cppipmy9wk53imq8lidz4xv1f";
  };
in
{
  home.packages = with pkgs; [ vim ];
  home.file = {
    ".vim/autoload/plug.vim".source = vimPlug;
    ".vimrc".source = ../../../stowed/.vimrc;
  };
}
