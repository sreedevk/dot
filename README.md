## Linux + Utils Configuration Dotfiles

This is a collection of my dot configuration files.
The following is my setup, but you get most dotfiles to work with your OS/Setup with minor tweaks.

##### My Setup

``` text
                   -`                    root@devstation
                  .o+`                   ---------------
                 `ooo/                   OS: Arch Linux x86_64
                `+oooo:                  Host: Precision 5540
               `+oooooo:                 Uptime: 16 hours, 57 mins
               -+oooooo+:                Shell: zsh 5.8
             `/:-:++oooo+:               CPU: Intel i9-9880H (16) @ 4.800GHz
            `/++++/+++++++:              GPU: Intel CoffeeLake-H GT2 [UHD Graphics 630]
           `/++++++++++++++:             GPU: NVIDIA Quadro T2000 Mobile / Max-Q
          `/+++ooooooooooooo/`           Memory: 32GB
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `/
```

### Documentation
I have tried to document every single software resource setup & configuration process. Checkout [Documentation](https://github.com/sreedevk/dot/tree/master/docs)

1. [i3wm](https://github.com/sreedevk/dot/tree/master/.i3 "Window Manager")
   i3wm is a great & simple-to-setup tiling window manager. The dot project contains a decently functional configuration for i3wm.
   Documentation: [i3 Docs](https://github.com/sreedevk/dot/blob/master/docs/i3wm.md)
   Project: [i3 Project](https://i3wm.org/)

2. [Alacritty](https://github.com/sreedevk/dot/tree/master/.config/alacritty "Terminal Emulator")
   A fast, cross-platform, OpenGL terminal emulator. It just works. The configurations adds some transparency,
   sets up fonts & sets default shell to zsh.
   Documentation: [Alacritty Docs](https://github.com/sreedevk/dot/blob/master/docs/alacritty.md)
   Project: [Alacritty Repo](https://github.com/alacritty/alacritty)

3. [Zsh](https://github.com/sreedevk/dot/blob/master/.zshrc "Shell")
   Best Interactive shell. The dot project adds an extensive set of customizations to the .zshrc.
   Documentation: [Zsh Docs](https://github.com/sreedevk/dot/blob/master/docs/zsh.md)
   Project: [Zsh Project](https://www.zsh.org/)

4. [Starship Prompt](https://github.com/sreedevk/dot/blob/master/.config/starship.toml "Shell Prompt")
    Starship is a great shell prompt. It offers decent level of freedom to customize. It supports both zsh & bash.
    Project: [Startship Project](https://starship.rs/)

5. [Polybar](https://github.com/sreedevk/dot/tree/master/.config/polybar "Status Bar")
   Polybar is a neat status bar your window manager. Thought there is a default polybar configuration available as a part
   of the dot project. The default status bar that is a part of the i3wm configuration is [bumblee_status](https://github.com/tobi-wan-kenobi/bumblebee-status).
   Project: [Polybar Repo](https://github.com/polybar/polybar)

6. [Asdf VM](https://github.com/sreedevk/dot/blob/master/.tool-versions "Software Version Manager")
   Asdf Version Manager is a universal version manager for all your programming languages / software. It allows you to install multiple versions of 
   everything from Ruby to Postgresql to Docker.
   Documentation: [ASDF VM Docs](https://github.com/sreedevk/dot/blob/master/docs/asdf.md)
   Project: [ASDF VM](http://asdf-vm.com/)

7. [Dunst](https://github.com/sreedevk/dot/tree/master/.config/dunst "Notification Manager")
   Dunst is a notification daemon that runs as a service. Its commonly used with lightweight window managers.
   Documentation: [Dunst Docs](https://github.com/sreedevk/dot/blob/master/docs/dunst.md)
   Project: [Dunst Repo](https://github.com/dunst-project/dunst)

8.  [Tmux](https://github.com/sreedevk/dot/blob/master/.tmux.conf "Terminal Multiplexer")
    Tmux is a terminal multiplexer. Since Alacritty terminal emulator that is considered to be default in the dot project,
    does not have a multi tab / tiling system, Tmux is highly recommended. The dot project adds some basic configuration
    for tmux that makes it sane enought to be used.
    Documentation: [Dunst Docs](https://github.com/sreedevk/dot/blob/master/docs/tmux.md)
    Project: [Tmux Repo](https://github.com/tmux/tmux)

9. [Neovim](https://github.com/sreedevk/dot/tree/master/.config/nvim "Text Editor")
   Vim has always been my favorite editor. Neovim just made it better with lil bit of magic. The neovim 
   config in the dot project is pretty straight forward with a limited number of plugins & keymaps.
   Documentation: [Neovim Docs](https://github.com/sreedevk/dot/blob/master/docs/neovim.md)
   Project: [Neovim Repo](https://github.com/neovim/neovim)

10. [Emacs](https://github.com/sreedevk/dot/tree/master/.doom.d/ "Text Editor")
   Emacs isn't exactly my goto editor, but I've found the doom emacs configuration to be quite useful & intuitive.
   The dot projects uses chemacs2 to multi load configurations. By Default, the dot project installs doom emacs, spacemacs & a custom emacs config
   with just doom themes & evil mode installed.
   Documentation: [Emacs Docs](https://github.com/sreedevk/dot/blob/master/docs/emacs.md)
   Project: [Emacs Project](https://www.gnu.org/software/emacs/)

11. [Custom Shell Scripts](https://github.com/sreedevk/dot/tree/master/.scripts "Utilities")
   Just a bunch of useful tools to make life in the terminal emulator / shell better.
   Documentation: [Custom Script Docs](https://github.com/sreedevk/dot/blob/master/docs/scripts.md)

12. [Git](https://github.com/sreedevk/dot/blob/master/.gitconfig "Version Control")
13. [Picom](https://github.com/sreedevk/dot/blob/master/.config/picom.conf "Compositor")

### Usage

GNU/Stow is a program that let's you manage dotfiles using a repository like the dot project.
The Dot project repository is designed to work with stow.

1. Clone This Repository Recursively

``` bash
git clone --recursive -j3 https://github.com/sreedevk/dot 
```

1. install GNU/stow which is available under the package name of stow in most distributions.

    Arch / Arch Based (pacman)
    ```bash
      pacman -S stow
    ```

    Debian / Debian Based (apt)
    ```bash
      apt-get install stow
    ```

2. run the stow command

    ```bash
      stow .
    ```

    OR 

    ```bash
      stow --dir=~/path/to/current/repo --target=~/
    ```

    OR 

    ```bash
      stow -d ~/path/to/current/repo -t ~/
    ```

### Requirements

In order to make the dotfiles work as expected, the following programs are expected to be installed on your machine.

1. [Alacritty](https://github.com/alacritty/alacritty)
2. [Tmux](https://github.com/tmux/tmux)
3. [Zsh](https://www.zsh.org/)
  - [Antibody](https://getantibody.github.io/) -- Run `antibody-compile` when opening zsh for the first time
  - [Starship Prompt](https://starship.rs/)
  - [Direnv](https://direnv.net/)
4. [i3](https://i3wm.org/)
5. [GNU emacs](https://www.gnu.org/software/emacs/)
6. [Neovim](https://neovim.io/)
6. [Git](https://git-scm.com/)
7. [Picom](https://github.com/yshui/picom)

### Recommendations

To make life better, using the following tools are recommended.

1. [Polybar](https://github.com/polybar/polybar)
2. [Xmonad](https://xmonad.org/)
3. [Xmobar](https://hackage.haskell.org/package/xmobar)

### Screenshots
![2021-10-11-003706_3840x2160_scrot](https://user-images.githubusercontent.com/36154121/136709891-82ea7c1b-217c-4e5c-a1ab-f1270a8baf71.png)

![2021-10-11-004313_3840x2160_scrot](https://user-images.githubusercontent.com/36154121/136710015-eb8eb325-f3be-42fa-9da5-3ca4cf5eb8c0.png)

