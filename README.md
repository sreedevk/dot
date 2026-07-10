<h2 align="center">Nix(OS) Configurations</h2>

This repository contains configurations for various programs & Nix(OS).
This Nix(OS) section of this repository is located in the `nixos` directory. 

> ⚠️ Reference only.
> This repo does not build as-is. This is a filtered public mirror of my private Nix configuration, published for reference and to share how I've set things up. It is not meant to be cloned and built directly. Certain paths are deliberately excluded from this repo's history, like secrets (agenix .age files), private host configurations, and other machine-specific bits. As a result, flake outputs will reference files that simply aren't here, and nixos-rebuild / nix build will fail on missing paths or unresolved references.

## TODO
1. bug: tmux/terminal reads C-i as \<tab\>
2. Switch to niri
3. Along with having one global VPN, have 2-3 gluetun containers that divide the services into groups and assign 1 gluetun container 0 per group.
4. system-manager is broken AF, https://github.com/numtide/system-manager/issues/349
   - it kicks the main user off the wheel group (thanks to userborn)
   - it sets the root user's shell to nix's bash installation
5. Complete setting up of ddns-updater [ currently doesn't support private IPs ](https://github.com/qdm12/ddns-updater/issues/809)
6. fix the problem where cw in nvim removes the space at end of line
8. Librepods repoint to old branch - May 16, 2026
9. Lockscreen wallpaper must be dark AF
10. when having multiple tabs open in neovim, when opening and closing neogit window, I am not back in the same tab I started in.
11. telescope incremental staged grep
12. faster way to start and stop systemd units using tmux + fzf
13. Add an fzf+tmux option to pick a just/rake task and run it in a new window & persist the window after the run. also add options to re-run the same action if possible
14. when a github repo has a different remote for pull and a different remote for push, we gotta setup gh cli to work properly
15. niri screensharing fix

## Distant Dreams
1. improvement: migrate to Traefik
2. k3s setup on apollo
3. disko setup on apollo

## Pre Requisites
### Install Home Manager CLI
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

##### Updating Flake.lock
Since we are using a `nixos/flake.lock` file, we need to update the flake inputs using the command below.

```bash
rake nix:flake:update
```

##### Checking Flake Integrity
```bash
# CHECK CURRENT SYSTEM
rake nix:flake:check

# CHECK ALL SYSTEMS
rake nix:flake:check:all
```

#### NixOS Operations
##### Rebuilding & Switching to NixOS Generations

```bash
# USING REMOTE CACHE
rake nix:os:install

# WITHOUT USING REMOTE CACHE
rake nix:os:install:offline
```

#### Home-Manager Operations
##### Rebuilding & Switching to Home-Manager Generations

```bash
# USING REMOTE CACHE
rake nix:home:install

# USING REMOTE CACHE AND BACKUP CONFLICTING FILE OVERWRITES
rake nix:home:install:backup

# WITHOUT USING REMOTE CACHE 
rake nix:home:install:offline

# WITHOUT USING REMOTE CACHE AND BACKUP CONFLICTING FILE OVERWRITES
rake nix:home:install:offline:backup
```
