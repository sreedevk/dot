{ pkgs, secrets, ... }:
{
  imports = [ ./shared ];
  home = {
    username = "sreedev";
    homeDirectory = "/home/sreedev";
    stateVersion = "23.11";
    packages = with pkgs; [
      amfora
      bat
      broot
      btop
      cmatrix
      direnv
      duckdb
      eza
      fastfetch
      fzf
      hledger
      httpie
      jira-cli-go
      lf
      uiua
      vim
      zoxide
    ];
  };
}
