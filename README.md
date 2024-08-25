# Dotfiles & Nix Configurations 

This repository contains configurations for various programs & Nix.
This Nix section of this repository is located in the `nixos` directory.

## Pre Requisites

### Install Home Manager CLI

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

## Usage
##### Installation

```bash
home-manager switch --flake './nixos' --impure --override-input secrets "github:devtechnica/nullflake?shallow=1"

# OR 
home-manager switch --flake './nixos#<NAME OF THE USER HERE>' --impure --override-input secrets "github:devtechnica/nullflake?shallow=1"
```

* `--impure` flag is required because nixGL uses `builtins.currentTime` as an impure parameter to force the rebuild on each access.
* `--override-input secrets ` flag will override the `secrets` input flake which is only accessible on my home network with a flake that returns an empty attribute set.

##### Upgrading Locked Packages
Since we are using a `nixos/flake.lock` file, we need to update the flake using the command below and rebuild the system as normal.

```bash
# TO BE RUN FROM THE ROOT OF THIS CLONED REPSITORY
nix flake update './nixos' --override-input secrets "github:devtechnica/nullflake?shallow=1"
```

## File Structure

### nixos/hosts
- The `nixos/hosts` contains the `configuration.nix` files for each of my computers that runs NixOS. 
- Each host is assigned a separate folder. 
- The configuration that `flake.nix` uses is decided by the hostname of the system.
- The creation of users is managed by the `configuration.nix` but all the user related configuration is handled by `home-manager`. The common link between the created user and configured user is just the username. This means that users with the same name on all systems will be configured the same way if `home-manager` is used configure the user.
- I have moved host configurations away from this repository, so only the barebones configurations.nix are left behind for each host

### nixos/users
- The `nixos/users` directory is the `home-manager` section of the configuration.
- Each username has a `username.nix` file that contains user level `home-manager` managed configurations.
- The `nixos/users/shared` directory contains modules that are shared across multiple users.

### nixos/flake.nix
This is the entrypoint for `home-manager`.

## Programs

- Editors: Vim + Neovim + Doom Emacs
- Terminals: Alacritty + Kitty
- Window Manager: i3
- Shells: ZSH + Bash
- IRC: irssi
- Task Management: Taskwarrior
- PDF Reader: Zathura
- Other CLI Tools: 
    tmux, delta-git, htop, btop, fastfetch, cava, csvlens, git, direnv, httpie
    hyperfine, jq, jaq, gping, ipcalc, ripgrep, ripgrep-all, ... 

