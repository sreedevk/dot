<h2 align="center">Nix(OS) Configurations</h2>

This repository contains configurations for various programs & Nix(OS).
This Nix(OS) section of this repository is located in the `nixos` directory. 

## TODO
1. bug: tmux/terminal reads C-i as \<tab\>
2. notes sync
3. deploying to apollo (nixOS) via colmena causes nixGL to fail to recognize the nvidia driver
4. keyboard layout "UNKNOWN" at login
5. Switch to niri
6. some dependencies that require secrets start before agenix.service has had the chance to run

## Distant Dreams
1. Get rid of the dependency on a static LAN ip address (potentially using DDNS)
2. improvement: migrate to Traefik
3. k3s setup on apollo
4. disko setup on apollo

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
