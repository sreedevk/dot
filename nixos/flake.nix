{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable&shallow=1";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05-small&shallow=1";
    agenix.url = "github:ryantm/agenix";

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

  outputs = { self, agenix, nixpkgs, firefox-addons, home-manager, stylix, ... } @ inputs:
    let
      opts = (import ./opts.nix);
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
          coalesced_opts = opts // (import ./hosts/${hostname}/opts.nix);
          agenix_pkg =
            [{ environment.systemPackages = [ agenix.packages.${system}.default ]; }];
        in
        pkgs.lib.nixosSystem {
          system = system;
          modules = [ agenix.nixosModules.default ./hosts/${hostname}/configuration.nix ] ++ agenix_pkg;
          specialArgs = {
            inherit system;
            nixpkgs-stable = inputs.nixpkgs-stable.legacyPackages."${system}";
            opts = coalesced_opts;
          };
        };

      mkHome =
        pkgs: system: username: host:
        let
          coalesced_opts = opts // (import ./hosts/${host}/opts.nix) // (import ./users/${username}/opts.nix);
          agenix_pkg = [{ home.packages = [ agenix.packages.${system}.default ]; }];
          stylix_mod =
            if coalesced_opts.desktop.enable == true
            then [ stylix.homeModules.stylix ]
            else [ ];
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.legacyPackages."${system}";
          modules = [ ./users/${username} agenix.homeManagerModules.age ] ++ agenix_pkg ++ stylix_mod;
          extraSpecialArgs = {
            inherit firefox-addons system username host inputs;
            nixpkgs-stable = inputs.nixpkgs-stable.legacyPackages."${system}";
            opts = coalesced_opts;
          };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations 
      nixosConfigurations = {
        nullptrderef1 = mkSystem nixpkgs systems.x86 "nullptrderef1";
        devstation = mkSystem nixpkgs systems.x86 "devstation";
        devtechnica = mkSystem nixpkgs systems.x86 "devtechnica";
        rpi4b = mkSystem nixpkgs systems.x86 "rpi4b";
      };

      # User Level Home Manager Configurations
      homeConfigurations = {
        admin = mkHome nixpkgs systems.x86 "admin" "nullptrderef1";
        deploy = mkHome nixpkgs systems.x86 "deploy" "devtechnica";
        pi = mkHome nixpkgs systems.arm64 "pi" "rpi4b";
        sreedev = mkHome nixpkgs systems.x86 "sreedev" "devstation";
      };
    };
}
