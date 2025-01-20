{ pkgs, ... }:
let
  vimPlug = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
    sha256 = "1nywzjd9nfr7sqqbdi69wza305q3vp26i0390j1884wdz6awid10";
  };
in
{
  home.packages = with pkgs; [ vim ];
  home.file = {
    ".vim/autoload/plug.vim".source = vimPlug;
    ".vimrc".source = ../../../stowed/.vimrc;
  };
}
