{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    secrets.url = "git+ssh://git@gitea.nullptr.sh/nullptrderef1/sec.git?ref=main&shallow=1";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable&shallow=1";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05-small&shallow=1";

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

  outputs = { self, secrets, nixpkgs, firefox-addons, home-manager, stylix, ... } @ inputs:
    let
      opts  = (import ./opts.nix);

      systems = {
        x86   = "x86_64-linux";
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
            nixpkgs-stable = inputs.nixpkgs-stable.legacyPackages."${system}";
            opts = opts // (import ./hosts/${hostname}/opts.nix);
          };
        };

      mkHome =
        pkgs: system: username: host: home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.legacyPackages."${system}";
          modules = [
            stylix.homeManagerModules.stylix
            ./users/${username}
          ];
          extraSpecialArgs = {
            inherit firefox-addons secrets system username host;
            nixpkgs-stable = inputs.nixpkgs-stable.legacyPackages."${system}";
            opts = opts // (import ./hosts/${host}/opts.nix) // (import ./users/${username}/opts.nix);
          };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations 
      nixosConfigurations = {
        devstation = mkSystem nixpkgs systems.x86 "devstation";
        devtechnica = mkSystem nixpkgs systems.x86 "devtechnica";
        rpi4b = mkSystem nixpkgs systems.x86 "rpi4b";
      };

      # User Level Home Manager Configurations
      homeConfigurations = {
        deploy = mkHome nixpkgs systems.x86 "deploy" "devtechnica";
        pi = mkHome nixpkgs systems.arm64 "pi" "rpi4b";
        sreedev = mkHome nixpkgs systems.x86 "sreedev" "devstation";
      };
    };
}
