{ pkgs, ... }:
pkgs.writeShellScriptBin "tmux-sessionizer" ''
  if [[ $# -eq 1 ]]; then
    selected=$1
  else
    selected=$(
        {
            fd . ~/Data/repositories/ ~/Data/labs/ ~/Data/**/repositories/ -td -d1
            zoxide query -l -a
        } | sed 's|/$||' | awk '!seen[$0]++' | fzf
    )
  fi

  if [[ -z $selected ]]; then
    exit 0
  fi

  selected_name=$(basename "$selected" | tr . _)
  tmux_running=$(pgrep tmux)

  if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    if [[ -f "$HOME/.config/tmuxinator/$selected_name.yml" ]]; then
      ${pkgs.tmuxinator}/bin/tmuxinator start $selected_name
    elif [[ -f "$selected/.tmuxinator.yml" ]]; then
      ${pkgs.tmuxinator}/bin/tmuxinator start --name=$selected_name -p "$selected/.tmuxinator.yml"
    else
      ${pkgs.tmux}/bin/tmux new-session -s $selected_name -c $selected
    fi

    exit 0
  fi

  if ! tmux has-session -t=$selected_name 2> /dev/null; then
    if [[ -f "$HOME/.config/tmuxinator/$selected_name.yml" ]]; then
      ${pkgs.tmuxinator}/bin/tmuxinator start --no-attach $selected_name
    elif [[ -f "$selected/.tmuxinator.yml" ]]; then
      ${pkgs.tmuxinator}/bin/tmuxinator start --name=$selected_name --no-attach -p "$selected/.tmuxinator.yml"
    else
      ${pkgs.tmux}/bin/tmux new-session -ds $selected_name -c $selected
    fi
  fi

  if [[ -z $TMUX ]]; then
    ${pkgs.tmux}/bin/tmux attach -t $selected_name
  else
    ${pkgs.tmux}/bin/tmux switch-client -t $selected_name
  fi
''
