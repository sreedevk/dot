<h1 align="center">The Dot Project</h1>
<p align="center">
This is a collection of my dot configuration files. The goal of this project is to make a very minimal & self contained configuration repository for Arch 
(& Arch Based) Linux Installations. Usage of external plugins have been kept to a very minimum.
</p>

![Screenshot](https://github.com/sreedevk/dot/blob/main/screenshots/_001.png?raw=true)

### What's in the box?
Configurations For
- Neovim - Written Entirely in Lua
- Tmux
- ZShell + Starship Prompt + Antibody Plugin Manager
- Bash
- i3 Window Manager + i3blocks + i3status
- Alacritty
- Picom Compositor
- Rofi Application Switcher

### Installation

You can either choose to install stow & link all the configurations to appropriate locations (NOT RECOMMENDED) or individually link configurations for specific applications. (RECOMMENDED)

#### Installing Configrations For Individual Applications
First, you need to clone the repository. (you can choose to clone to a different location)

```bash
  $ git clone https://github.com/sreedevk/dot ~/.dot
```
<details>
<summary><b><u>Neovim</u></b></summary>

##### Neovim
The dot project has a very elaborate neovim config written entirely in lua. The Neovim config on the dot project is aimed to serve developers. You may want to use a different config if you don't use neovim for coding / software development.

###### Prerequisites
- [Neovim >0.8.0](https://neovim.io/)
- [Neovim Packer](https://github.com/wbthomason/packer.nvim)
- [NodeJS](https://nodejs.org/en/)
- [pynvim](https://github.com/neovim/pynvim)

###### Config Structure
```
stowed/.config/nvim
├── coc-settings.json                   -- Code Completion
├── init.lua                            -- Entry Point
├── lua
│   ├── colors.lua                      -- Setting up Tokyonight THeme
│   ├── commands.lua                    -- Some Custom Commands
│   ├── funk.lua                        -- Utils
│   ├── mappings.lua                    -- Sane Mappings
│   ├── opts.lua                        -- Neovim Sane Defaults
│   ├── plugins.lua                     -- Plugins
│   ├── status.lua                      -- Neovim Status Line
│   └── _telescope.lua                  -- Neovim Telescope Configration
└── plugin
└── packer_compiled.lua             -- Packer Compiled Plugins
```

###### Linking Configs

```bash
# Remove Existing Config!!
$ rm -rf ~/.config/nvim/

# link dot project neovim config
$ ln -s ~/.dot/stowed/.config/nvim ~/.config/nvim/
```

###### Installing Neovim Plugins
On first startup after linking configs, run :PackerInstall to install all the plugin dependencies

</details>

<details>
  <summary><b><u>Tmux</u></b></summary>

##### Tmux
Fancy tmux setup with multiline status bars & vim key bindings.

###### Prerequisites
- [Tmux >v3.3](https://github.com/tmux/tmux)
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

###### Config Structure
```
 - stowed/.tmux.conf
```
###### Linking Configs
```bash
  # Remove Existing Config!!
  $ rm -rf ~/.tmux.conf

  # Linking Scripts
  $ mkdir -p ~/.local/bin/
  $ chmod +x ~/.dot/stowed/.local/bin/tmux_status_right.sh
  $ ln ~/.dot/stowed/.local/bin/tmux_status_right.sh ~/.local/bin/tmux_status_right.sh

  # link dot project neovim config
  $ ln -s ~/.dot/stowed/.tmux.conf ~/.tmux.conf
```

###### Installing Tmux Plugins
On first startup after linking configs, Press prefix + I (capital i, as in Install) to fetch the tmux plugin dependencies.
</details>

<details>
  <summary>
    <b><u>ZShell + Starship Prompt + Antibody</u></b>
  </summary>

##### ZShell + Starship Prompt + Antibody
Lightweight but functional ZShell setup with Starship prompt & Antibody Plugin Manager

###### Prerequisites
- [ZShell >=v5.9](https://www.zsh.org/)
- [Anitbody Plugin Manager](https://getantibody.github.io/)
- [Starship Prompt](https://starship.rs/)

###### Config Structure

```
stowed/.zshrc
stowed/.zsh
├── .zsh_aliases        -- aliases to commonly used commands with options
├── .zsh_autoloads      -- autoloads for various shell utilities you may or may not have
├── .zsh_functions      -- custom functions
├── .zsh_fzf            -- fzf setup
├── .zsh_plugins        -- zsh plugin list
└── .zsh_plugins.sh     -- zsh compiled plugins
```
###### Linking Configs

```bash
  # Remove Existing Config!!
  rm -rf ~/.zsh ~/.zshrc

  # Link New Configs
  ln -s ~/.dot/stowed/.zshrc ~/.zshrc
  ln -s ~/.dot/stowed/.zsh ~/.zsh
```
###### Installing ZShell Plugins
On first startup, run `antibody-compile` to download and compile zsh plugins

</details>

<details>
  <summary>
    <b><u>Bash</u></b>
  </summary>

##### Bash
Bash config on the dot project is very basic & minimal.

###### Prerequisites
- [Bash >=5.1.16](https://www.gnu.org/software/bash/)

###### Config Structure
```
stowed/.bashrc
```
###### Linking Configs
```bash
  # Remove Existing Config!!
  rm -rf ~/.bashrc ~/.profile

  # Link New Configs
  ln -s ~/.dot/stowed/.bashrc ~/.bashrc
  ln -s ~/.dot/stowed/.profile ~/.profile
```
</details>

<details>
  <summary>
    <b><u>i3wm + i3blocks + i3status + Picom</u></b>
  </summary>

##### i3wm + i3blocks + i3status + Picom
The dot project has a detailed self-contained functional i3wm setup

###### Prerequisites
REQUIRED
- [i3wm](https://i3wm.org/)
- [Nitrogen](https://wiki.archlinux.org/title/nitrogen)
- [i3blocks](https://github.com/vivien/i3blocks)
- [Picom](https://github.com/yshui/picom)
- [Jetbrain fonts](https://archlinux.org/packages/community/any/ttf-jetbrains-mono/)
- [Rofi](https://github.com/davatorium/rofi)
- [Alacritty](https://github.com/alacritty/alacritty)

OPTIONAL
- [xfce-power-manager](https://archlinux.org/packages/extra/x86_64/xfce4-power-manager/)
- [volumeicon](https://archlinux.org/packages/community/x86_64/volumeicon/)
- [nm-applet](https://archlinux.org/packages/extra/x86_64/network-manager-applet/)
- [i3-scrot](https://github.com/pazuzu156/i3scrot)

###### Config Structure
```
stowed/.config/i3
├── autostart.sh            -- xrandr setup
└── config                  -- main config
stowed/.config/i3blocks
├── blocks                  -- status bar building blocks
│   ├── battery
│   ├── cpu
│   ├── dnd
│   ├── gpu
│   ├── ip
│   └── memory
└── config                  -- i3blocks config
```
###### Linking Configs
```bash
  # removing existing configs!!
  $ rm -rf ~/.i3 ~/.config/i3 ~/.config/i3blocks

  # linking new configs
  ln -s ~/.dot/stowed/.config/i3 ~/.config/i3
  ln -s ~/.dot/stowed/.config/i3blocks ~/.config/i3blocks/
```

Restart your existing i3wm session to use the dot project i3wm config.

</details>

<details>
  <summary>
    <b><u>Alacritty</u></b>
  </summary>

##### Alacritty
Minimal config for Alacritty terminal with Tokyonight theme.

###### Prerequisites
- [Alacritty](https://github.com/alacritty/alacritty)

#### Linking Configs
```bash
  # remove existing configs!!
  $ rm -rf ~/.config/alacritty/alacritty.yml ~/.alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty.yml

  # linking new configs
  $ mkdir -p ~/.config/alacritty
  $ ln -s ~/.dot/stowed/.config/alacritty/alacritty.yml 
```
Alacritty will apply the changes as soon as the new config is linked.


</details>

<details>
  <summary>
    <b><u>Rofi</u></b>
  </summary>

##### Rofi
Rofi Application Launcher

###### Prerequisites
- [Rofi](https://github.com/davatorium/rofi)

###### Linking Configs
```bash
  # remove existing configs!!!
  $ rm -rf ~/.config/rofi/config.rasi

  # linking new configs
  $ ln -s ~/.dot/stowed/.config/rofi ~/.config/rofi
```
The new configs will be automatically applied on next launch of Rofi


</details>

#### Installing All Configurations
1. Clone the repository

```bash
  $ git clone https://github.com/sreedevk/dot ~/.dot
```

2. Run the script to Install Dependences

```bash
  $ chmod +x ~/.dot/installer/arch/base.sh
  $ ~/.dot/installer/arch/base.sh
```

3. Run Stow

```bash
  $ cd ~/.dot && stow stowed
```

### Troubleshooting

When using GNU stow, please ensure that you have removed all current configurations from your system. Stow will not overwrite existing files.
