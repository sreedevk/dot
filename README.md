<h2 align="center">Nix(OS) Configurations</h2>

This repository contains configurations for various programs & Nix(OS).
This Nix(OS) section of this repository is located in the `nixos` directory.

> ⚠️ Reference only.
> This repo does not build as-is. This is a filtered public mirror of my private Nix configuration, published for reference and to share how I've set things up. It is not meant to be cloned and built directly. Certain paths are deliberately excluded from this repo's history, like secrets (agenix .age files), private host configurations, and other machine-specific bits. As a result, flake outputs will reference files that simply aren't here, and nixos-rebuild / nix build will fail on missing paths or unresolved references.

## TODO
1. [FIX] common: tmux/terminal reads C-i as \<tab\>
2. [IMP] apollo,orion: gluetun based split up of container networks.
3. [FIX] common: when a github repo has a different remote for pull and a different remote for push, gh cli needs to be setup properly
4. [FIX] phoenix,odoo: niri screensharing for discord
5. [IMP] apollo,orion: migrate to Traefik
6. [IMP] apollo: k3s setup with network storage
7. [IMP] apollo: setup disko nix
8. [IMP] apollo: fix internal container communication dependency on static ip addr

## Pre Requisites

### Install just
All repository tasks are defined in the `justfile` and run with [just](https://just.systems).

`just` is only needed to bootstrap a machine — once home-manager is applied it comes from the home-manager profile. So there is no need to install it permanently; drop into an ephemeral shell instead:

```bash
nix-shell -p just
```

Or run a single recipe without entering the shell:

```bash
nix-shell -p just --run 'just nix-home-install'
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

## Bootstrapping an Arch Host From Scratch

On Arch hosts, packages are split across two worlds:

- **Nix / home-manager** owns everything it can: user packages, dotfiles, services.
- **metapac** owns everything that must be native: kernel-adjacent packages, GPU drivers, 32-bit userspace, udev rules, and anything sandbox-hostile.

The steps below must run in this order. There is one bootstrap cycle to break: `metapac` and `paru` are both installed by home-manager, but they manage the native packages that home-manager cannot — so the home-manager switch has to happen before any native package can be synced.

### 1. Base system

Install Arch as usual. Before continuing, enable the `multilib` repository in `/etc/pacman.conf` — the 32-bit driver and Steam packages will not resolve without it.

```bash
sudo pacman -Syu
```

### 2. Install AUR build prerequisites

`paru` itself comes from Nix, but it shells out to `makepkg` to build AUR packages, and `makepkg` needs a native toolchain. This is the only group of packages that must be installed with `pacman` by hand.

```bash
sudo pacman -S --needed base-devel git
```

### 3. Install Nix

```bash
curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --no-confirm
```

Open a new shell afterwards so that Nix lands on `PATH`.

### 4. Clone this repository

```bash
git clone <repo> ~/.dot && cd ~/.dot
```

### 5. Install home-manager and apply the configuration

Everything from here runs inside an ephemeral shell with `just` available:

```bash
nix-shell -p just
```

```bash
just nix-home-manager-install
just nix-home-install-backup
```

Use the `-backup` variant for the first switch: a fresh Arch install ships dotfiles that will collide with the ones home-manager wants to write, and this moves them aside instead of failing.

This step installs `metapac` and `paru`, and generates metapac's config and group files at `~/.config/metapac/`.

### 6. Link the GPU drivers (nvidia hosts)

`targets.genericLinux.gpu` builds a driver set and exposes it at `/run/opengl-driver`. home-manager prints a `non-nixos-gpu-setup` command at the end of the switch — run it with `sudo`.

This must be re-run after every nvidia driver update, since the store path changes with the driver version.

### 7. Install native packages

```bash
# REVIEW WHAT IS INSTALLED BUT NOT DECLARED
just arch-unmanaged

# INSTALL EVERYTHING DECLARED BUT MISSING
just arch-sync
```

### 8. Reboot

Re-login so that the session environment (`XDG_DATA_DIRS`, flatpak exports, uwsm env) is picked up.

## Continuous Integration

CI runs on a self-hosted [Woodpecker](https://woodpecker-ci.org) instance against the private repository. The GitHub repository is a filtered public mirror and deliberately does not build, so nothing is run against it.

Pipelines live in `.woodpecker/`, which Woodpecker resolves automatically — each file is an independent pipeline with its own trigger conditions.

### .woodpecker/check.yaml
Runs on every push and pull request.

- **format** runs `nix fmt` and fails if it changed anything, so unformatted code cannot land.
- **flake-check**  runs `nix flake check --impure --all-systems`.

### .woodpecker/build.yaml
Runs on pushes to `main`. Builds each host's configuration as a matrix, so a broken package or eval error is caught before it reaches a machine rather than during a deploy.

### Caching

Each step runs in a fresh container, so without a persistent store every run re-fetches nixpkgs from scratch. Either mount a host directory over `/nix` (requires the repository to be marked **trusted** in Woodpecker's project settings, since volume mounts are an escalated capability), or point the agents at a binary cache.

## Checking Configs Locally

```bash
docker compose run --remove-orphans check
```

## File Structure

### arch
- Native `/etc` files and other system-level configuration for Arch hosts, placed by `system-manager`.
- Package declarations do **not** live here — those are in each host's `metapac.nix`.

### stowed
- Dotfiles that are symlinked recursively into `$HOME` by home-manager.
- The name is historical; GNU stow is not used and never was in the current setup.

### lib
- Shared Nix helper functions used across the flake outputs.

### .envrc
- direnv entrypoint for the repository's development shell.

### nixos/hosts

- The `nixos/hosts` contains the `configuration.nix` files for each of my machines that runs NixOS.
- Each host is assigned a separate folder.
- The creation of users is managed by the `configuration.nix` but all the user related configuration is handled by `home-manager`. The common link between the created user and configured user is just the username & hostname ("\<username\>@\<hostname\>".

### nixos/hosts/\<host\>/users
- The `users` directory under each host in the nixos/hosts directory is the home-manager configuration for a specific user for that host.
- Each user has a `<username>/default.nix` file that's the entrypoint for that user for home-manager.

### nixos/hosts/\<host\>/users/\<username\>/modules
- Home-manager modules scoped to a single user on a single host, rather than shared across machines.
- `metapac.nix` declares the native (non-Nix) packages for that host and generates metapac's `config.toml` and group file into `~/.config/metapac/`.
- Because each machine only ever sees the packages meant for it, metapac's `hostname_groups` mechanism is not used — the groups folder contains just that machine's group file, and metapac loads everything it finds there.

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

Remote targets need Nix reachable from a **non-interactive** SSH session. Interactive logins read `~/.profile`, but `ssh host command` does not — so the Nix profile script must be sourced from `~/.bashrc` **above** the `[[ $- != *i* ]] && return` guard on the target. Without this, deploys fail with `nix-store not found in PATH` even though Nix is installed.

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

##### Home-Manager Hosts

Builds the activation package locally, copies the closure to the target, and activates it over SSH.

```bash
just hm-deploy devtechnica sreedev
```

##### Installing System Manager Configuration Locally

```bash
just nix-system-install
```

##### Cross Compiling for aarch64 Targets

Deploying to `rpi4b` from an `x86_64` host requires building `aarch64-linux` derivations. Even a fully cached config still has to *run* trivial builders (generated unit files, `writeText` derivations) on the target architecture, so substitution alone is not enough.

`qemu-user-static` and `qemu-user-static-binfmt` are declared in the metapac arch group. Confirm the handler is registered with the `F` (fix binary) flag, which is what makes the interpreter available inside the Nix build sandbox:

```bash
cat /proc/sys/fs/binfmt_misc/qemu-aarch64
```

Then add the platform to `/etc/nix/nix.conf` and restart the daemon:

```
extra-platforms = aarch64-linux
```

```bash
sudo systemctl restart nix-daemon
```

Nix will now transparently emulate `aarch64-linux` builds, and `just sm-deploy rpi4b` works from an x86_64 host.

## Arch Linux Operations

Native packages are managed declaratively with [metapac](https://github.com/ripytide/metapac). Packages are declared per host in `nixos/hosts/<host>/users/<username>/modules/metapac.nix`, which home-manager renders into `~/.config/metapac/config.toml` and `~/.config/metapac/groups/`.

Each machine only sees the packages declared for it, so metapac's `hostname_groups` mechanism is unused — every group file present is loaded.

Enabled backends are `arch` (via `paru`, covering both repo and AUR packages), `cargo`, and `flatpak`.

```bash
# INSTALL DECLARED PACKAGES THAT ARE MISSING
just arch-sync

# LIST PACKAGES INSTALLED BUT NOT DECLARED
just arch-unmanaged

# UPDATE PACKAGES ACROSS ALL ENABLED BACKENDS
just arch-update
```

Because the group files are generated by home-manager, they are read-only symlinks into the Nix store, so metapac's mutating commands (`add`, `install`, `remove`, `uninstall`) will not work. To add a package: declare it in that host's `metapac.nix`, run `just nix-home-install`, then `just arch-sync`.

## Scripts

```bash
# FUZZY SEARCH AVAILABLE FIREFOX ADDONS
just scripts-list-firefox-addons

# ADD THE NUR CHANNEL
just scripts-add-nur-channel
```
