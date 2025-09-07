{
  description = "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable&shallow=1";
    stablepkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05&shallow=1";
    agenix.url = "github:ryantm/agenix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , agenix
    , nixpkgs
    , stablepkgs
    , home-manager
    , stylix
    , ...
    }@inputs:
    let
      opts = import ./nixos/opts.nix;
      systems = {
        x86 = "x86_64-linux";
        arm64 = "aarch64-linux";
      };

      mkFormatters =
        systemsl:
        builtins.foldl' (
          output: sys: output // { ${sys} = nixpkgs.legacyPackages."${sys}".nixfmt-tree; }
        ) { } (nixpkgs.lib.attrValues systemsl);

      mkSystem =
        system: hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            agenix.nixosModules.default
            ./nixos/hosts/${hostname}/configuration.nix
          ];

          specialArgs = {
            inherit system;
            opts = opts // import ./nixos/hosts/${hostname}/opts.nix;
          };
        };

      mkHome =
        system: username: host:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = import ./nixos/users/overlays { inherit inputs; };
          };

          modules = [
            ./nixos/users/${username}
            agenix.homeManagerModules.age
            stylix.homeModules.stylix
          ];

          extraSpecialArgs = {
            inherit
              system
              username
              host
              inputs
              ;
            opts = opts // import ./nixos/hosts/${host}/opts.nix // import ./nixos/users/${username}/opts.nix;
          };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations
      nixosConfigurations = {
      };

      # User Level Home Manager Configurations
      homeConfigurations = {
        sreedev = mkHome systems.x86 "sreedev" "devstation";
      };
    };
}
