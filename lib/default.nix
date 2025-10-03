{
  inputs,
  outputs,
  opts,
}:
let
  inherit (inputs) nixpkgs agenix stylix;
in
rec {

  recurmerge =
    attrsets: nixpkgs.lib.fold (attrset: acc: nixpkgs.lib.recursiveUpdate attrset acc) { } attrsets;

  mkColmenaFromNixOSConfigurations =
    conf:
    inputs.colmena.lib.makeHive (
      {
        meta = {
          description = "Home Server Deployments";
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = import ../nixos/common/overlays { inherit inputs; };
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
        agenix.nixosModules.default
        ../nixos/hosts/${hostname}/configuration.nix
      ];

      specialArgs = {
        inherit system;
        opts = recurmerge [
          opts
          (import ../nixos/hosts/${hostname}/opts.nix)
        ];
      };
    };

  mkArchSystem =
    system: hostname:
    inputs.system-manager.lib.makeSystemConfig {
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
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        overlays = import ../nixos/common/overlays { inherit inputs; };
      };

      modules = [
        ../nixos/hosts/${host}/users/${username}
        agenix.homeManagerModules.age
        stylix.homeModules.stylix
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

  mkArchSystems =
    list:
    builtins.listToAttrs (
      map (x: {
        name = x.host;
        value = mkArchSystem x.system x.host;
      }) list
    );
}
