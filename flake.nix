{
  description = "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {

    nixpkgs.url    = "github:nixos/nixpkgs?ref=nixos-unstable&shallow=1";
    stablepkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05&shallow=1";
    agenix.url     = "github:ryantm/agenix";
    colmena.url    = "github:zhaofengli/colmena";
    attic.url      = "github:zhaofengli/attic";
    llama-cpp.url  = "github:ggml-org/llama.cpp?ref=b7126";

    disko = {
      url                    = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url                    = "github:nix-community/NUR?ref=250154e2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url                    = "github:sreedevk/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url                    = "github:danth/stylix?ref=cd11c057";
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
      url                    = "github:outfoxxed/quickshell?ref=v0.2.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url                    = "github:noctalia-dev/noctalia-shell?ref=v3.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url                    = "github:sodiboo/niri-flake?ref=960b925b";
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
          { host = "apollo";    system = systems.x86; }
          { host = "farfalle";  system = systems.x86; }
        ];

      # Arch linux system configs
      systemConfigs =
        mkNonNixSystems [
          { host = "devstation";  system = systems.x86;   }
          { host = "devtechnica"; system = systems.x86;   }
          { host = "rpi4b";       system = systems.arm64; }
        ];

      # User Level Home Manager Configurations
      homeConfigurations = 
        mkHomes [
          { user = "admin";   host = "apollo";        system = systems.x86;   }
          { user = "deploy";  host = "devtechnica";   system = systems.x86;   }
          { user = "pi";      host = "rpi4b";         system = systems.arm64; }
          { user = "sreedev"; host = "devstation";    system = systems.x86;   }
        ];
    };
}
