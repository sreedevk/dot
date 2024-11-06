{ pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    ediff = true;
    settings = {
      ui = {
        default-command = "log";
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
