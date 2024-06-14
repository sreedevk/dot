{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      systems = {
        x86 = "x86_64-linux";
        arm64 = "aarch64-linux";
      };

      secrets =
        builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");

      mkFormatter = sys: {
        "${sys}" = inputs.nixpkgs.legacyPackages."${sys}".nixpkgs-fmt;
      };

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [ (import ./hosts/${hostname}/configuration.nix) ];
          specialArgs = { inherit inputs secrets; };
        };

      mkHome = pkgs: system: username:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.legacyPackages."${system}";
          modules = [ stylix.homeManagerModules.stylix ./users/${username}.nix ];
          extraSpecialArgs = { inherit inputs secrets system username; };
        };
    in
    {
      # Formatters for Nix Files
      formatter = {
        "${systems.x86}" = mkFormatter systems.x86;
        "${systems.arm64}" = mkFormatter systems.arm64;
      };

      # Operating System Level Configurations 
      nixosConfigurations = {
        nullptrderef1 = mkSystem inputs.nixpkgs systems.x86 "nullptrderef1";
      };

      # User Level Home Manager Configurations
      homeConfigurations = {
        admin = mkHome inputs.nixpkgs systems.x86 "admin";
        sreedev = mkHome inputs.nixpkgs systems.x86 "sreedev";
        pi = mkHome inputs.nixpkgs systems.arm64 "pi";
      };
    };
}
