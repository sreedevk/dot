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
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      x86system = "x86_64-linux";
      armsystem = "aarch64-linux";
      secrets =
        builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
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
          extraSpecialArgs = { inherit inputs secrets; };
        };
    in
    {
      formatter = {
        "${x86system}" = inputs.nixpkgs.legacyPackages."${x86system}".nixpkgs-fmt;
        "${armsystem}" = inputs.nixpkgs.legacyPackages."${armsystem}".nixpkgs-fmt;
      };

      nixosConfigurations = {
        nullptrderef1 = mkSystem inputs.nixpkgs x86system "nullptrderef1";
      };

      homeConfigurations = {
        admin = mkHome inputs.nixpkgs x86system "admin";
        sreedev = mkHome inputs.nixpkgs x86system "sreedev";
        pi = mkHome inputs.nixpkgs armsystem "pi";
      };
    };
}
