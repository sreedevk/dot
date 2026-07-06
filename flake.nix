{
  description = "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {

    agenix.url     = "github:ryantm/agenix";
    attic.url      = "github:zhaofengli/attic";
    colmena.url    = "github:zhaofengli/colmena";
    llama-cpp.url  = "github:ggml-org/llama.cpp?ref=b9859";
    nixpkgs.url    = "github:nixos/nixpkgs?ref=nixos-unstable&shallow=1";
    stablepkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05&shallow=1";
    vicinae.url    = "github:vicinaehq/vicinae?ref=v0.22.0";

    direnv-instant = {
      url                    = "github:Mic92/direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url                    = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url                    = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url                    = "github:nix-community/NUR?ref=ebb520e";
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

    quickshell = {
      url                    = "github:outfoxxed/quickshell?ref=v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url                    = "github:noctalia-dev/noctalia-shell?ref=v5.0.0-beta1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url                    = "github:sodiboo/niri-flake?ref=c110481";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pam = {
      url                    = "github:Cu3PO42/pam_shim?ref=next";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self, ... } @ inputs:
    let
      inherit (self) outputs;
      opts = import ./nixos/opts.nix;
      systems = {
        x86 = "x86_64-linux";
        arm64 = "aarch64-linux";
      };

      inherit (import ./lib { inherit inputs outputs opts systems; })
        mkSystems
        mkHomes 
        mkFormatters
        mkNonNixSystems
        mkColmenaFromNixOSConfigurations
        forEachSystem;

    in
    {
      # Colmena Deployments 
      colmenaHive = mkColmenaFromNixOSConfigurations self.nixosConfigurations;

      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # checks
      checks = forEachSystem (pkgs: {
        lint = pkgs.runCommand "nixlint" { nativeBuildInputs = with pkgs; [ deadnix statix ]; } ''
          deadnix --fail ${./.}
          statix check ${./.}
          touch $out
        '';
      });

      # Operating System Level Configurations
      nixosConfigurations = 
        mkSystems [
          { host = "apollo"; system = systems.x86; }
          { host = "orion";  system = systems.x86; }
        ];

      # Arch linux system configs
      systemConfigs =
        mkNonNixSystems [
          { host = "devtechnica"; system = systems.x86;   }
          { host = "phoenix";     system = systems.x86;   }
          { host = "rpi4b";       system = systems.arm64; }
          { host = "odoo";        system = systems.x86;   }
        ];

      # User Level Home Manager Configurations
      homeConfigurations = 
        mkHomes [
          { user = "admin";   host = "apollo";        system = systems.x86;   }
          { user = "deploy";  host = "devtechnica";   system = systems.x86;   }
          { user = "pi";      host = "rpi4b";         system = systems.arm64; }
          { user = "sreedev"; host = "phoenix";       system = systems.x86;   }
          { user = "u0";      host = "orion";         system = systems.x86;   }
          { user = "srkod";   host = "odoo";          system = systems.x86;   }
        ];
    };
}
