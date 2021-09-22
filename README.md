### This is a collection of my dot configuration files.

#### Configurations
1. [Dunst](https://github.com/sreedevk/dot/tree/master/dunst "Notification Manager")
2. [Tmux](https://github.com/sreedevk/dot/tree/master/tmux "Terminal Multiplexer")
3. [Neovim](https://github.com/sreedevk/dot/tree/master/neovim "Text Editor")
4. [X](https://github.com/sreedevk/dot/tree/master/X "Display Server")
5. [Custom Shell Scripts](https://github.com/sreedevk/dot/tree/master/scripts "Utilities")
6. [Zsh](https://github.com/sreedevk/dot/tree/master/zsh "Shell")
7. [Asdf VM](https://github.com/sreedevk/dot/tree/master/asdf "Software Version Manager")
8. [Alacritty](https://github.com/sreedevk/dot/tree/master/alacritty "Terminal Emulator")
9. [Starship Prompt](https://github.com/sreedevk/dot/blob/master/starship/ "Shell Prompt")
10. [Git](https://github.com/sreedevk/dot/blob/master/git/ "Version Control")
11. [Polybar](https://github.com/sreedevk/dot/blob/master/polybar/ "Status Bar")
12. [i3WM](https://github.com/sreedevk/dot/blob/master/i3/ "Window Manager")
13. [Picom](https://github.com/sreedevk/dot/blob/master/i3/ "Compositor")


#### USING GNU/STOW TO AUTOMATE SETTING UP SYMBOLIC LINKS

1. install gnu/stow which is available under the package name of stow in most distributions.

    Arch / Arch Based (pacman)
    ```bash
      pacman -S stow
    ```

    Debian / Debian Based (apt)
    ```bash
      apt-get install stow
    ```

2. checkout to the `stow` branch on this repository && pull the latest code

    ```bash
      git checkout stow && git pull origin stow
    ```

3. run the stow command

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
