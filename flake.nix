{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable&shallow=1";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.05-small&shallow=1";
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

  outputs = { self, agenix, nixpkgs, home-manager, stylix, ... } @ inputs:
    let
      opts = import ./nixos/opts.nix;
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
        pkgs: system: hostname:
        let
          coalesced_opts = opts // (import ./nixos/hosts/${hostname}/opts.nix);
          agenix_pkg =
            [{ environment.systemPackages = [ agenix.packages.${system}.default ]; }];
        in
        pkgs.lib.nixosSystem {
          inherit system;
          modules = [ agenix.nixosModules.default ./nixos/hosts/${hostname}/configuration.nix ] ++ agenix_pkg;
          specialArgs = {
            inherit system;
            nixpkgs-stable = inputs.nixpkgs-stable.legacyPackages."${system}";
            opts = coalesced_opts;
          };
        };

      mkHome =
        pkgs: system: username: host:
        let
          coalesced_opts = opts // (import ./nixos/hosts/${host}/opts.nix) // (import ./nixos/users/${username}/opts.nix);
          agenix_pkg = [{ home.packages = [ agenix.packages.${system}.default ]; }];
          stylix_mod =
            if coalesced_opts.desktop.enable
            then [ stylix.homeModules.stylix ]
            else [ ];
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              inputs.nixgl.overlay
              inputs.nur.overlays.default
            ];
          };
          modules = [ ./nixos/users/${username} agenix.homeManagerModules.age ] ++ agenix_pkg ++ stylix_mod;
          extraSpecialArgs = {
            inherit system username host inputs;
            nixpkgs-stable = inputs.nixpkgs-stable.legacyPackages."${system}";
            opts = coalesced_opts;
          };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations 
      nixosConfigurations = { };

      # User Level Home Manager Configurations
      homeConfigurations = {
        sreedev = mkHome nixpkgs systems.x86 "sreedev" "devstation";
      };
    };
}
