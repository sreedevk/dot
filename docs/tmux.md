# Tmux
Fancy tmux setup with multiline status bars & vim key bindings.

## Dependencies
- [Tmux >v3.3](https://github.com/tmux/tmux)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

## Installation
```bash
# Clone the Dot Project
$ git clone https://github.com/sreedevk/dot ~/.dot

# Remove Existing Config!!
$ rm -rf ~/.tmux.conf

# Linking Scripts
$ mkdir -p ~/.local/bin/
$ chmod +x ~/.dot/stowed/.local/bin/tmux_status_right.sh
$ ln ~/.dot/stowed/.local/bin/tmux_status_right.sh ~/.local/bin/tmux_status_right.sh

# link dot project neovim config
$ ln -s ~/.dot/stowed/.tmux.conf ~/.tmux.conf
```

## Installing Tmux Plugins
On first startup after linking configs, Press prefix + I (<C-b> + I) to fetch the tmux plugin dependencies.
