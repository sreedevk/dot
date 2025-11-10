{ inputs
, opts
, systems
, ...
}:
let
  inherit (inputs) nixpkgs agenix stylix home-manager colmena system-manager disko noctalia;
in
rec {
  pkgsFor = nixpkgs.legacyPackages;
  forEachSystem = f: nixpkgs.lib.genAttrs (builtins.attrValues systems) (sys: f pkgsFor.${sys});

  recurmerge =
    attrsets: nixpkgs.lib.fold (attrset: acc: nixpkgs.lib.recursiveUpdate attrset acc) { } attrsets;

  mkColmenaFromNixOSConfigurations =
    conf:
    colmena.lib.makeHive (
      {
        meta = {
          description = "Home Server Deployments";
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = import ../nixos/common/overlays { inherit inputs; };
            config = {
              allowUnfree = true;
              allowBroken = true;
            };
          };
          nodeNixpkgs = builtins.mapAttrs (_: value: value.pkgs) conf;
          nodeSpecialArgs = builtins.mapAttrs (_: value: value._module.specialArgs) conf;
        };
      }
      // builtins.mapAttrs (_: value: { imports = value._module.args.modules; }) conf
    );

  mkFormatters =
    systemsl:
    builtins.foldl' (
      output: sys: output // { ${sys} = nixpkgs.legacyPackages."${sys}".nixfmt-tree; }
    ) { } (nixpkgs.lib.attrValues systemsl);

  mkSystem =
    system: hostname:
    nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        disko.nixosModules.disko
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        ../nixos/hosts/${hostname}/configuration.nix
      ];

      extraModules = [
        colmena.nixosModules.deploymentOptions
      ];

      specialArgs = {
        inherit system inputs;
        opts = recurmerge [
          opts
          (import ../nixos/hosts/${hostname}/opts.nix)
        ];
      };
    };

  mkNonNixSystem =
    system: hostname:
    system-manager.lib.makeSystemConfig {
      modules = [
        ../nixos/hosts/${hostname}/configuration.nix
      ];
      extraSpecialArgs = {
        inherit system;
        opts = recurmerge [
          opts
          (import ../nixos/hosts/${hostname}/opts.nix)
        ];
      };
    };

  mkHome =
    system: username: host:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        overlays = import ../nixos/common/overlays { inherit inputs; };
      };

      modules = [
        ../nixos/hosts/${host}/users/${username}
        agenix.homeManagerModules.age
        stylix.homeModules.stylix
        noctalia.homeModules.default
      ];

      extraSpecialArgs = {
        inherit
          system
          username
          host
          inputs
          ;
        opts = recurmerge [
          opts
          (import ../nixos/hosts/${host}/opts.nix)
          (import ../nixos/hosts/${host}/users/${username}/opts.nix)
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

  mkNonNixSystems =
    list:
    builtins.listToAttrs (
      map (x: {
        name = x.host;
        value = mkNonNixSystem x.system x.host;
      }) list
    );
}
