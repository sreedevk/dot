# Dotfiles & Nix(OS) Configurations

This repository contains configurations for various programs & Nix(OS).

This Nix(OS) section of this repository is located in the `nixos` directory. The structure & layout of this directory is as follows.

### nixos/hosts

- The `nixos/hosts` contains the `configuration.nix` files for each of my computers that runs NixOS. 
- Each host is assigned a separate folder. 
- The configuration that `flake.nix` uses is decided by the hostname of the system.
- The creation of users is managed by the `configuration.nix` but all the user related configuration is handled by `home-manager`. The common link between the created user and configured user is just the username. This means that users with the same name on all systems will be configured the same way if `home-manager` is used configure the user.

### nixos/users
- The `nixos/users` directory is the `home-manager` section of the configuration.
- Each username has a `username.nix` file that contains user level `home-manager` managed configurations.
- The `nixos/users/shared` directory contains modules that are shared across multiple users.

### nixos/secrets

- This directory contains a `secrets.json` file (encrypted using git crypt). which should contain a JSON object.
- This JSON object is made available to both the home-manager user configurations in `nixos/users` & system configurations in `nixos/hosts` via the `secrets` function parameter.
- Here's the format of `secrets.json` 
<details>
    <summary>click to expand `secrets.json` format</summary>

    ```json
    {
      "system": {
        "password": "xxx"
      },
      "jira": {
        "token": "xxx"
      },
      "freshrss": {
        "password": "XXX"
      },
      "cargo": {
        "token": "XXX"
      },
      "digital_ocean": {
        "token": "XXX"
      },
      "restic": {
        "password": "XXX"
      },
      "openweather": {
        "token": "XXX"
      },
      "pastebin": {
        "token": "XXX"
      },
      "spotify": {
        "client_id": "XXX",
        "client_secret": "XXX",
        "password": "XXX"
      },
      "wallhaven": {
        "token": "XXX"
      },
      "plex": {
        "claim": "XXX"
      },
      "photoprism": {
        "password": "XXX"
      },
      "mullvad": {
        "account": "XXX",
        "location": "XXX"
      },
      "firefly": {
        "db": {
          "password": "XXX"
        },
        "app": {
          "site_owner": "XXX",
          "secret": "XXX"
        }
      },
      "livebook": {
        "password": "XXX"
      },
      "icecast": {
        "password": "XXX"
      },
      "farfalle": {
        "tavily_api_key": "XXX"
      },
      "taskwarrior": {
        "client_id": "XXX",
        "encryption_secret": "XXX"
      }
    }
    ```
</details>

```nix
{ config, lib, pkgs, secrets, ... }:
{}
```

### nixos/flake.nix

This is the entrypoint for both the `home-manager` & `NixOS`. 

#### NixOS

##### Modifications

After making any changes in the `nixos/hosts` directory, you can install the changes to the current host configuration into NixOS using the following command on the host.

```bash
# TO BE RUN FROM THE ROOT OF THIS CLONED REPSITORY
sudo nixos-rebuild switch --flake "./nixos"

# OR 

sudo nixos-rebuild switch --flake "./nixos#<NAME OF THE HOST HERE>"
```

##### Upgrading 

Since we are using a `nixos/flake.lock` file, we need to update the flake using the command below and rebuild the system as normal.

```bash
# TO BE RUN FROM THE ROOT OF THIS CLONED REPSITORY
nix flake update './nixos'
```

#### Home-Manager

##### Modifications

Any modifications to the `nixos/users` directory can be installed using this `home-manager` command

```bash
home-manager switch --flake './nixos'

# OR 
home-manager switch --flake './nixos#<NAME OF THE USER HERE>'
```

##### Upgrading

Since we are using a `nixos/flake.lock` file, we need to update the flake using the command below and rebuild using `home-manager`.

```bash
# TO BE RUN FROM THE ROOT OF THIS CLONED REPSITORY
nix flake update './nixos'
```

## Programs
category | programs
:-------:|:--------:
editors | (Neo)vim / (Doom)emacs
shells  | zsh / bash / starship
wms     | i3wm / polybar / rofi / picom
terminals | alacritty / tmux
notifications | dunst
other | fastfetch / git

### Editors

#### Neovim
<details>
    <summary>click to expand</summary>
    Since, neovim is handled by `home-manager` entirely, no additional steps are required to setup neovim
</details>

#### Doom Emacs
<details>
    <summary>click to expand</summary>
    doom emacs configuration files are installed by `home-manager` but installed doom emacs itself needs to be handled manually according to the instructions in <a href="https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install">doomemacs repository</a>
</details>

### Shells
-- TODO: 

### Window Managers
-- TODO: 

### Terminals
-- TODO: 

### Notifications
-- TODO: 

### Other
-- TODO: 


