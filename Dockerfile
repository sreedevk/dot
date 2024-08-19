FROM nixos/nix

# Set up environment for building the NixOS configuration
RUN nix-channel --update

# Copy your flake files to the Docker image
COPY ./nixos /workspace
WORKDIR /workspace

RUN nix --extra-experimental-features flakes --extra-experimental-features nix-command flake lock --override-input sec "github:devtechnica/nullflake?shallow=1"
CMD nix --extra-experimental-features flakes --extra-experimental-features nix-command build '.#nixosConfigurations.nullptrderef1.config.system.build.toplevel' --no-link
