{
  description = "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
      mkSystem = pkgs: system: hostname: user:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            (import ./hosts/${hostname}/configuration.nix)
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${user}" = (import ./hosts/${hostname}/users/${user}.nix);
              };
            }
          ];
          specialArgs = { inherit inputs secrets; };
        };
    in
    {
      nixosConfigurations = {
        nullptrderef1 = mkSystem inputs.nixpkgs system "nullptrderef1" "admin";
      };
    };
}
