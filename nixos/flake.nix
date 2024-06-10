{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
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
          modules = [ (import ./users/${username}.nix) ];
          extraSpecialArgs = { inherit inputs secrets; };
        };
    in
    {
      formatter.x86_64-linux =
        inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt;

      nixosConfigurations = {
        nullptrderef1 = mkSystem inputs.nixpkgs system "nullptrderef1";
      };

      homeConfigurations = {
        admin = mkHome inputs.nixpkgs system "admin";
        sreedev = mkHome inputs.nixpkgs system "sreedev";
      };
    };
}
