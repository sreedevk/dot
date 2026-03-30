{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo  = "fzf.fish";
          rev   = "main";
          hash  = "sha256-H7HgYT+okuVXo2SinrSs+hxAKCn4Q4su7oMbebKd/7s=";
        };
      }
    ];
  };
}
