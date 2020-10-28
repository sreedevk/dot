# i3 config linking
if [[ "$(uname -r)" =~ "MANJARO" ]]
then
  mkdir -p ~/.i3/
  rm ~/.i3/config
  ln ./i3/manjaro_i3_config ~/.i3/config
else
  mkdir -p ~/.config/i3
  ln ./i3/config ~/.config/i3/config
  rm ~/.config/i3/config
fi

# alacritty config linking
mkdir -p ~/.config/alacritty
rm ~/.config/alacritty/alacritty.yml
ln ./alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml


# shell configs
case $SHELL in
*bash*)
  # bash config
  rm ~/.bashrc
  ln './bash/.bashrc' ~/.bashrc
  ;;
*zsh*)
  # zsh config
  mkdir ~/.old_zsh_configs
  mv ~/{.zshrc,.zsh_plugins.sh,.zsh_aliases,.zsh_funcs,.zsh_plugins.txt} ~/.zsh_old_configs
  ln ./zsh/{.zsh_aliases,.zsh_funcs,.zsh_aliases,.zsh_plugins.sh,.zsh_plugins.txt} ~/
  ;;
esac
