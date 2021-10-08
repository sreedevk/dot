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

### Configurations
1. [Dunst](https://github.com/sreedevk/dot/tree/master/.config/dunst "Notification Manager")
2. [Tmux](https://github.com/sreedevk/dot/blob/master/.tmux.conf "Terminal Multiplexer")
3. [Neovim](https://github.com/sreedevk/dot/tree/master/.config/nvim "Text Editor")
4. [Xresources](https://github.com/sreedevk/dot/blob/master/.Xresources "Display Server")
5. [Xmodmap](https://github.com/sreedevk/dot/blob/master/.Xmodmap "Custom Key Mapping")
6. [Custom Shell Scripts](https://github.com/sreedevk/dot/tree/master/.scripts "Utilities")
7. [Zsh](https://github.com/sreedevk/dot/blob/master/.zshrc "Shell")
8. [Asdf VM](https://github.com/sreedevk/dot/blob/master/.tool-versions "Software Version Manager")
9. [Alacritty](https://github.com/sreedevk/dot/tree/master/.config/alacritty "Terminal Emulator")
10. [Starship Prompt](https://github.com/sreedevk/dot/blob/master/.config/starship.toml "Shell Prompt")
11. [Git](https://github.com/sreedevk/dot/blob/master/.gitconfig "Version Control")
12. [Polybar](https://github.com/sreedevk/dot/tree/master/.config/polybar "Status Bar")
13. [i3WM](https://github.com/sreedevk/dot/tree/master/.i3 "Window Manager")
14. [Picom](https://github.com/sreedevk/dot/blob/master/.config/picom.conf "Compositor")


### Using GNU/Stow

GNU/Stow is a program that let's you manage dotfiles. This dotfiles repository is designed to work with stow.

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
