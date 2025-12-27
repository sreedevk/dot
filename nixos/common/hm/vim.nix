{ pkgs, ... }:
let
  vimPlug = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/junegunn/vim-plug/3f17a5cc3d7b0b7699bb5963fef9435a839dada0/plug.vim";
    sha256 = "1d6gad5lagdngj7z6mvmj6avmracvhvqdvhmbdgyfra861brx6g0";
  };
in
{
  home.packages = with pkgs; [ vim ];
  home.file = {
    ".vim/autoload/plug.vim".source = vimPlug;
    ".vimrc".source = ../../../stowed/.vimrc;
  };
}
