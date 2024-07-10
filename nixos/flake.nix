{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    sec.url = "git+ssh://git@gitea.nullptrderef1.duckdns.org/nullptrderef1/sec.git?ref=main&shallow=1";

    nixpkgs-os.url = "github:nixos/nixpkgs?ref=nixos-unstable&shallow=1";
    nixpkgs-hm.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable&shallow=1";
    nixpkgs-ms.url = "github:nixos/nixpkgs?ref=master&shallow=1";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-hm";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-hm";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-hm";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      opts = (import ./opts.nix);
      secrets = inputs.sec.secrets;

      systems = {
        x86 = "x86_64-linux";
        arm64 = "aarch64-linux";
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
          specialArgs = { inherit inputs secrets system opts; };
        };

      mkHome = pkgs: system: username:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.legacyPackages."${system}";
          modules = [
            stylix.homeManagerModules.stylix
            ./users/${username}.nix
          ];
          extraSpecialArgs = { inherit inputs secrets system username opts; };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations 
      nixosConfigurations = {
        nullptrderef1 = mkSystem inputs.nixpkgs-os systems.x86 "nullptrderef1";
      };

      # User Level Home Manager Configurations
      homeConfigurations = {
        admin = mkHome inputs.nixpkgs-hm systems.x86 "admin";
        sreedev = mkHome inputs.nixpkgs-hm systems.x86 "sreedev";
        pi = mkHome inputs.nixpkgs-hm systems.arm64 "pi";
        deploy = mkHome inputs.nixpkgs-hm systems.x86 "deploy";
      };
    };
}
