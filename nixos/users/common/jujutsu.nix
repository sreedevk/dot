{ pkgs, config, ... }:
{
  programs.jujutsu = {
    enable = true;
    ediff = true;
    settings = {
      ui = {
        default-command = "log";
        editor = "${config.programs.neovim.package}/bin/nvim";
        pager = "${pkgs.delta}/bin/delta";
        graph = {
          style = "square";
        };
        diff = {
          format = "git";
          tool = [ "${pkgs.difftastic}/bin/difft" "--color=always" "$left" "$right" ];
        };
      };
      signing = {
        sign-all = true;
        backend = "gpg";
        key = "B8C402B16E80E17C";
      };
      user = {
        name = "sreedevk";
        email = "sreedev@icloud.com";
      };
    };
  };
}
