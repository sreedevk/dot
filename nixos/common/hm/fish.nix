{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      # {
      #   name = "fzf-fish";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "PatrickF1";
      #     repo  = "fzf.fish";
      #     rev   = "main";
      #     hash  = "sha256-KO2EM2ZneF8QCcL2gJ4ZJBY4q2xmGD7eu3TMWBImjjo=";
      #   };
      # }
    ];
  };
}
