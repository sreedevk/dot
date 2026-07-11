# list all recipes
default:
    @just --list --unsorted

# format configuration
[group('nix')]
nix-format:
    nix fmt

# colmena deploy
[group('nix')]
nix-deploy host:
    colmena apply --impure --on {{ host }}

# system-manager deploy
[group('nix')]
sm-deploy host:
    nix run 'github:numtide/system-manager' -- --target-host {{ host }} switch --sudo --flake '.#{{ host }}'

[group('nix')]
hm-deploy user host:
    #!/usr/bin/env bash
    set -euo pipefail
    out=$(nix build ".#homeConfigurations.{{ user }}@{{ host }}.activationPackage" --impure --no-link --print-out-paths)
    nix copy --to "ssh://{{ host }}" "$out"
    ssh {{ host }} "$out/activate"

# update nix flake.lock and commit lockfile
[group('nix')]
nix-flake-update-lock:
    nix flake update --commit-lock-file

# update nix flake.lock
[group('nix')]
nix-flake-update:
    nix flake update

# check nix flakes & configurations for current system
[group('nix')]
nix-flake-check:
    nix flake check --impure

# check nix flakes & configurations for all systems
[group('nix')]
nix-flake-check-all:
    nix flake check --impure --all-systems

# rebuild & install nixos configuration offline
[group('nix')]
nix-os-install-offline:
    nixos-rebuild switch --offline --flake '.' --sudo --impure -j 8

# collect garbage
[group('nix')]
nix-os-gc:
    sudo nix-collect-garbage -d

# rebuild & install nixos configuration
[group('nix')]
nix-os-install:
    nixos-rebuild switch --flake '.' --sudo --impure -j 8

# install system-manager configuration
[group('nix')]
nix-system-install:
    nix run 'github:numtide/system-manager' -- switch --flake '.' --sudo

# install home-manager && initialize
[group('nix')]
nix-home-manager-install:
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install

# rebuild home manager configuration
[group('nix')]
nix-home-build:
    home-manager build --impure --flake ".#$(whoami)@$(hostname)" -j 8

# collect garbage
[group('nix')]
nix-home-gc:
    nix-collect-garbage -d

# rebuild & install home-manager config
[group('nix')]
nix-home-install:
    home-manager switch --impure --flake ".#$(whoami)@$(hostname)" -j 8

# rebuild & install home-manager config offline
[group('nix')]
nix-home-install-offline:
    home-manager switch --impure --option substitute false --flake ".#$(whoami)@$(hostname)" -j 8

# rebuild & install home-manager config and backup replaced files
[group('nix')]
nix-home-install-backup:
    home-manager switch --impure --flake ".#$(whoami)@$(hostname)" -j 8 -b backup

# rebuild & install home-manager config offline and backup replaced files
[group('nix')]
nix-home-install-offline-backup:
    home-manager switch --impure --option substitute false --flake ".#$(whoami)@$(hostname)" -j 8 -b backup

# --- arch ---

# archive packages from arch/aur/flatpak/cargo
[group('arch')]
arch-archive:
    ./bin/archive-packages

# restore packages from arch/aur/flatpak/cargo
[group('arch')]
arch-restore:
    ./bin/restore-packages

# --- scripts ---

# list firefox addons
[group('scripts')]
scripts-list-firefox-addons:
    nix-env -f '<nixpkgs>' -qaP -A nur.repos.rycee.firefox-addons | awk '{print $2}' | fzf

# add nur channel
[group('scripts')]
scripts-add-nur-channel:
    nix-channel --add https://github.com/nix-community/NUR/archive/master.tar.gz nur
    nix-channel --update -v

# create a temporary clone of the repository for publishing
[group('publishing')]
clone_for_publishing:
  git clone --no-local . /tmp/dot_public

# filter private history from the cloned repository
[group('publishing')]
filter_private_history:
  git filter-repo --path secrets/ --path nixos/hosts/apollo --path nixos/hosts/orion/ --path nixos/hosts/rpi4b/ --path nixos/hosts/devtechnica/ --invert-paths

# prepare cloned repository for publishing
[group('publishing')]
prepare_for_publishing: clone_for_publishing
  cd /tmp/dot_public && just filter_private_history && git remote add origin git@github.com:sreedevk/dot

# publish cloned repository to the public mirror
[group('publishing')]
publish: prepare_for_publishing
  cd /tmp/dot_public && git push origin main --force && rm -rf /tmp/dot_public
