{ pkgs, secrets, ... }:
{
  imports = [ ./shared ];
  home = {
    username = "sreedev";
    homeDirectory = "/home/sreedev";
    stateVersion = "23.11";
    packages = with pkgs; [
      amfora
      cmatrix
      btop
      direnv
      duckdb
      eza
      fzf
      hledger
      httpie
      jira-cli-go
      uiua
      zoxide
      bat
      lf
      fastfetch
      vim
    ];
  };
}
