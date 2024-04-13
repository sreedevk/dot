{
  description = "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs } @ inputs:
    let
      system = "x86_64-linux";
      secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            (import ./hosts/${hostname}/configuration.nix)
          ];
          specialArgs = { inherit inputs secrets; };
        };
    in
    {
      nixosConfigurations = {
        nullptrderef1 = mkSystem inputs.nixpkgs system "nullptrderef1";
      };
    };
}
