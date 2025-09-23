{ pkgs, ... }:
let
  vimPlug = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/junegunn/vim-plug/904dac1530cfec0880cd44e4f7f206eb2e9e3247/plug.vim";
    sha256 = "01kkg3c05si97r4kkdhn5n17kcqp56hjh4d74l9aajd0d629kn62";
  };
in
{
  home.packages = with pkgs; [ vim ];
  home.file = {
    ".vim/autoload/plug.vim".source = vimPlug;
    ".vimrc".source = ../../../stowed/.vimrc;
  };
}
