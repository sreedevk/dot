{
  description = "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url    = "github:nixos/nixpkgs?ref=nixos-unstable&shallow=1";
    stablepkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05&shallow=1";
    agenix.url     = "github:ryantm/agenix";
    colmena.url    = "github:zhaofengli/colmena";

    nur = {
      url                    = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url                    = "github:sreedevk/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url                    = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url                    = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url                    = "github:numtide/system-manager";
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

      recurmerge =
        attrsets: nixpkgs.lib.fold (attrset: acc: nixpkgs.lib.recursiveUpdate attrset acc) { } attrsets;

      mkFormatters =
        systemsl:
        builtins.foldl' (
          output: sys: output // { ${sys} = nixpkgs.legacyPackages."${sys}".nixfmt-tree; }
        ) { } (nixpkgs.lib.attrValues systemsl);

      mkSystem =
        system: hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = 
            [
              agenix.nixosModules.default
              ./nixos/hosts/${hostname}/configuration.nix
            ];

          specialArgs = {
            inherit system;
            opts = 
              recurmerge [
                opts
                (import ./nixos/hosts/${hostname}/opts.nix)
              ];
          };
        };

      mkArchSystem =
        system: hostname:
        inputs.system-manager.lib.makeSystemConfig {
          modules = 
            [
              ./nixos/hosts/${hostname}/configuration.nix 
            ];
          extraSpecialArgs = {
            inherit system;
            opts = recurmerge [
              opts
              (import ./nixos/hosts/${hostname}/opts.nix)
            ];
          };
        };

      mkHome =
        system: username: host:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = import ./nixos/common/overlays { inherit inputs; };
          };

          modules = 
            [
              ./nixos/hosts/${host}/users/${username}
              agenix.homeManagerModules.age
              stylix.homeModules.stylix
            ];

          extraSpecialArgs = {
            inherit system username host inputs;
            opts = 
              recurmerge [
                opts
                (import ./nixos/hosts/${host}/opts.nix)
                (import ./nixos/hosts/${host}/users/${username}/opts.nix)
              ];
          };
        };

      mkHomes =
        list:
        builtins.listToAttrs (
          map (x: {
            name = "${x.user}@${x.host}";
            value = mkHome x.system x.user x.host;
          }) list
        );

      mkSystems =
        list:
        builtins.listToAttrs (
          map (x: {
            name = x.host;
            value = mkSystem x.system x.host;
          }) list
        );

      mkArchSystems =
        list:
        builtins.listToAttrs (
          map (x: {
            name = x.host;
            value = mkArchSystem x.system x.host;
          }) list
        );
    in
    {
      # Colmena Deployments
      colmenaHive = inputs.colmena.lib.makeHive {
        meta = {
          nixpkgs = import nixpkgs {
            system = systems.x86;
            overlays = [
            ];
          };
        };
        nullptrderef1 = {
          deployment = {
            targetHost = "nullptrderef1";
            targetPort = 22;
            targetUser = "admin";
          };
          specialArgs = {
            system = systems.x86;
            opts = 
              recurmerge [
                opts
                (import ./nixos/hosts/nullptrderef1/opts.nix)
              ];
          };
          boot.isContainer = false;
          time.timeZone = "America/New_York";
          imports = [
            ./nixos/hosts/nullptrderef1/configuration.nix
          ];
        };
      };

      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations
      nixosConfigurations = 
        mkSystems [
          { host = "devstation";    system = systems.x86;   }
          { host = "devtechnica";   system = systems.x86;   }
          { host = "nullptrderef1"; system = systems.x86;   }
          { host = "rpi4b";         system = systems.arm64; }
        ];

      # Arch linux system configs
      systemConfigs =
        mkArchSystems [
          { host = "apollo"; system = systems.x86; }
        ];

      # User Level Home Manager Configurations
      homeConfigurations = 
        mkHomes [
          { user = "admin";   host = "nullptrderef1"; system = systems.x86;   }
          { user = "deploy";  host = "devtechnica";   system = systems.x86;   }
          { user = "pi";      host = "rpi4b";         system = systems.arm64; }
          { user = "sreedev"; host = "apollo";        system = systems.x86;   }
          { user = "sreedev"; host = "devstation";    system = systems.x86;   }
        ];
    };
}
