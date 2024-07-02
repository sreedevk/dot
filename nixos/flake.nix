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
      opts = (import ./opts.nix);

      systems = {
        x86 = "x86_64-linux";
        arm64 = "aarch64-linux";
      };

      secrets =
        builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");

      userutils = {
        randStr = len:
          builtins.concatStrings (builtins.map (char: builtins.toString (char + 33)) (builtins.genList (i: builtins.randInt 0 93) len));
      };

      mkFormatters =
        systemsl: builtins.foldl'
          (output: sys: output // { ${sys} = inputs.nixpkgs.legacyPackages."${sys}".nixpkgs-fmt; })
          { }
          (nixpkgs.lib.attrValues systemsl);

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            (import ./hosts/${hostname}/configuration.nix)
          ];
          specialArgs = { inherit inputs secrets system opts userutils; };
        };

      mkHome = pkgs: system: username:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.legacyPackages."${system}";
          modules = [
            stylix.homeManagerModules.stylix
            ./users/${username}.nix
          ];
          extraSpecialArgs = { inherit inputs secrets system username opts userutils; };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

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
