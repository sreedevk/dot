{ pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    ediff = true;
    settings = {
      ui = {
        default-command = "log";
      };
      user = {
        name = "sreedevk";
        email = "sreedev@icloud.com";
      };
    };
  };
}
