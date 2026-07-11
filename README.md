<h2 align="center">Nix(OS) Configurations</h2>

This repository contains configurations for various programs & Nix(OS).
This Nix(OS) section of this repository is located in the `nixos` directory.

> ⚠️ Reference only.
> This repo does not build as-is. This is a filtered public mirror of my private Nix configuration, published for reference and to share how I've set things up. It is not meant to be cloned and built directly. Certain paths are deliberately excluded from this repo's history, like secrets (agenix .age files), private host configurations, and other machine-specific bits. As a result, flake outputs will reference files that simply aren't here, and nixos-rebuild / nix build will fail on missing paths or unresolved references.

## TODO
1. [FIX] common: tmux/terminal reads C-i as \<tab\>
2. [IMP] apollo,orion: gluetun based split up of container networks.
3. [IMP] apollo,orion: setup ddns-updater [ currently doesn't support private IPs ](https://github.com/qdm12/ddns-updater/issues/809)
4. [FIX] common: when a github repo has a different remote for pull and a different remote for push, gh cli needs to be setup properly
5. [FIX] phoenix,odoo: niri screensharing for discord
1. [IMP] apollo,orion: migrate to Traefik
2. [IMP] apollo: k3s setup with network storage
3. [IMP] apollo: setup disko nix

## Pre Requisites

### Install just
All repository tasks are defined in the `justfile` and run with [just](https://just.systems).

```bash
nix profile add nixpkgs#just
```

Run `just` with no arguments to list every available recipe:

```bash
just
```

### Install Home Manager CLI
```bash
just nix-home-manager-install
```

Which runs:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

### Install System Manager CLI
```bash
nix profile add 'github:numtide/system-manager'
```

## Using Docker Compose to Check Configs

```bash
docker compose run --remove-orphans check
```

## File Structure
### nixos/hosts

- The `nixos/hosts` contains the `configuration.nix` files for each of my machines that runs NixOS.
- Each host is assigned a separate folder.
- The creation of users is managed by the `configuration.nix` but all the user related configuration is handled by `home-manager`. The common link between the created user and configured user is just the username & hostname ("\<username\>@\<hostname\>".

### nixos/hosts/\<host\>/users
- The `users` directory under each host in the nixos/hosts directory is the home-manager configuration for a specific user for that host.
- Each user has a `<username>/default.nix` file that's the entrypoint for that user for home-manager.

### nixos/common/hm
- This directory contains all the home-manager modules that are shared by multiple users across multiple hosts

### nixos/common/os
- This directory contains all the nixos modules that are shared by multiple hosts.

### nixos/common/overlays
- This directory contains all the overlays for nixpkgs used by both nixos and home-manager.

### nixos/common/secrets/mappings.nix
- This is the file that maps *.age files inside the `${ROOT}/secrets` directory to variables that are used by various home-manager & nixos modules.

### secrets
- the `secrets` directory contains all the age encrypted files managed by agenix for both home-manager & nixos modules.

### flake.nix
This is the entry point for both the `home-manager` & `NixOS`.

#### Flake Operations

##### Formatting the Configuration
```bash
just nix-format
```

##### Updating Flake.lock
Since we are using a `nixos/flake.lock` file, we need to update the flake inputs using the command below.

```bash
# UPDATE FLAKE INPUTS
just nix-flake-update

# UPDATE FLAKE INPUTS AND COMMIT THE LOCKFILE
just nix-flake-update-lock
```

##### Checking Flake Integrity
```bash
# CHECK CURRENT SYSTEM
just nix-flake-check

# CHECK ALL SYSTEMS
just nix-flake-check-all
```

#### NixOS Operations
##### Rebuilding & Switching to NixOS Generations

```bash
# USING REMOTE CACHE
just nix-os-install

# WITHOUT USING REMOTE CACHE
just nix-os-install-offline
```

##### Garbage Collection

```bash
just nix-os-gc
```

#### Home-Manager Operations
##### Rebuilding & Switching to Home-Manager Generations

```bash
# USING REMOTE CACHE
just nix-home-install

# USING REMOTE CACHE AND BACKUP CONFLICTING FILE OVERWRITES
just nix-home-install-backup

# WITHOUT USING REMOTE CACHE
just nix-home-install-offline

# WITHOUT USING REMOTE CACHE AND BACKUP CONFLICTING FILE OVERWRITES
just nix-home-install-offline-backup
```

##### Building Without Switching

```bash
just nix-home-build
```

##### Garbage Collection

```bash
just nix-home-gc
```

#### Remote Deployment
##### Colmena Hosts

```bash
just nix-deploy apollo
just nix-deploy orion
```

##### System Manager Hosts

```bash
just sm-deploy rpi4b
just sm-deploy devtechnica
```

##### Installing System Manager Configuration Locally

```bash
just nix-system-install
```

## Arch Linux Operations

Package lists for arch/aur/flatpak/cargo are archived to and restored from this repository.

```bash
# ARCHIVE INSTALLED PACKAGES
just arch-archive

# RESTORE PACKAGES FROM ARCHIVE
just arch-restore
```

## Scripts

```bash
# FUZZY SEARCH AVAILABLE FIREFOX ADDONS
just scripts-list-firefox-addons

# ADD THE NUR CHANNEL
just scripts-add-nur-channel
```
