{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    sec.url = "git+ssh://git@gitea.nullptr.sh/nullptrderef1/sec.git?ref=main&shallow=1";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable&shallow=1";

    # nixgl = {
    #   url = "github:nix-community/nixGL";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, sec, nixpkgs, firefox-addons, home-manager, stylix, ... }:
    let
      opts = (import ./opts.nix);
      secrets = sec.secrets;

      systems = {
        x86 = "x86_64-linux";
        arm64 = "aarch64-linux";
      };

      mkFormatters =
        systemsl: builtins.foldl'
          (output: sys: output // { ${sys} = nixpkgs.legacyPackages."${sys}".nixpkgs-fmt; })
          { }
          (nixpkgs.lib.attrValues systemsl);

      mkSystem =
        pkgs: system: hostname: pkgs.lib.nixosSystem {
          system = system;
          modules = [
            (import ./hosts/${hostname}/configuration.nix)
          ];
          specialArgs = {
            inherit secrets system;
            opts = opts // (import ./hosts/${hostname}/opts.nix);
          };
        };

      mkHome =
        pkgs: system: username: home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.legacyPackages."${system}";
          modules = [
            stylix.homeManagerModules.stylix
            ./users/${username}
          ];
          extraSpecialArgs = {
            inherit firefox-addons secrets system username;
            opts = opts // (import ./users/${username}/opts.nix);
          };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations 
      nixosConfigurations = {
        nullptrderef1 = mkSystem nixpkgs systems.x86 "nullptrderef1";
      };

      # User Level Home Manager Configurations
      homeConfigurations = {
        admin = mkHome nixpkgs systems.x86 "admin";
        deploy = mkHome nixpkgs systems.x86 "deploy";
        pi = mkHome nixpkgs systems.arm64 "pi";
        sreedev = mkHome nixpkgs systems.x86 "sreedev";
      };
    };
}
