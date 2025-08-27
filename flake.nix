{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable&shallow=1";
    stablepkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05&shallow=1";
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

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?shallow=1"; # rev=v0.2.0
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self
    , agenix
    , nixpkgs
    , stablepkgs
    , home-manager
    , stylix
    , ...
    } @ inputs:
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
        system: hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            agenix.nixosModules.default
            ./nixos/hosts/${hostname}/configuration.nix
          ];
          specialArgs = {
            inherit system;
            opts = opts // import ./nixos/hosts/${hostname}/opts.nix;
          };
        };

      mkHome =
        system: username: host:
        let
          coalesced_opts = opts // import ./nixos/hosts/${host}/opts.nix // import ./nixos/users/${username}/opts.nix;
          stylix_mod =
            if coalesced_opts.desktop.enable
            then [ stylix.homeModules.stylix ]
            else [ ];
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = import ./nixos/users/overlays { inherit inputs; };
          };
          modules = builtins.concatLists
            [
              [
                ./nixos/users/${username}
                agenix.homeManagerModules.age
              ]
              stylix_mod
            ];

          extraSpecialArgs = {
            inherit system username host inputs;
            opts = coalesced_opts;
          };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations 
      nixosConfigurations = {
        nullptrderef1 = mkSystem systems.x86 "nullptrderef1";
        devstation = mkSystem systems.x86 "devstation";
        devtechnica = mkSystem systems.x86 "devtechnica";
        rpi4b = mkSystem systems.x86 "rpi4b";
      };

      # User Level Home Manager Configurations
      homeConfigurations = {
        admin = mkHome systems.x86 "admin" "nullptrderef1";
        deploy = mkHome systems.x86 "deploy" "devtechnica";
        pi = mkHome systems.arm64 "pi" "rpi4b";
        sreedev = mkHome systems.x86 "sreedev" "devstation";
      };
    };
}
