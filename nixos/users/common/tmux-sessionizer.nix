{ pkgs, opts, username, ... }:
let
  tmux-sessionizer =
    pkgs.writeShellScriptBin "tmux-sessionizer" ''
      # This script is an improved version of The Primeagen's tmux sessionizer
      # https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer.
      #
      # The following are the changes from the primeagen's original version:
      # 1. use fd instead of find (performance improvement)
      # 2. allows integration with global tmuxinator session configs.
      #      if a tmuxinator session exists in ~/.config/tmuxinator/<project>.yml, 
      #      and the project directory name matches the name of .yml file, then tmuxinator
      #      is invoked instead of tmux.

      if [[ $# -eq 1 ]]; then
        selected=$1
      else
        selected=$(fd . ~/Data/repositories/ ~/Data/**/repositories/ -td -d1 | fzf)
      fi

      if [[ -z $selected ]]; then
        exit 0
      fi

      selected_name=$(basename "$selected" | tr . _)
      tmux_running=$(pgrep tmux)

      if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        if [[ -f "$HOME/.config/tmuxinator/$\{selected_name\}.yml" ]]; then
          tmuxinator start $selected_name
        else
          tmux new-session -s $selected_name -c $selected
        fi

        exit 0
      fi

      if ! tmux has-session -t=$selected_name 2> /dev/null; then
        if [[ -f "$HOME/.config/tmuxinator/$\{selected_name\}.yml" ]]; then
          tmuxinator start $selected_name
        else
          tmux new-session -ds $selected_name -c $selected
        fi
      fi

      if [[ -z $TMUX ]]; then
        tmux attach -t $selected_name
      else
        tmux switch-client -t $selected_name
      fi
    '';
in
{
  home.packages = [ tmux-sessionizer ];
}
  

