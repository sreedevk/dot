{
  description =
    "NixOS System Configuration Management Flake for Multiple Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      systems = {
        x86 = "x86_64-linux";
        arm64 = "aarch64-linux";
      };

      opts = {
        applicationUserName = "nullptrderef1";
        lanAddress = "192.168.1.179";
        timeZone = "America/New_York";
        adminUID = "1000";
        adminGID = "100";
        paths = {
          application_data = "/mnt/dpool0/appdata";
          downloads = "/mnt/dpool0/downloads";
          magazines = "/mnt/dpool0/media/magazines";
          qbt_images = "/mnt/dpool0/media/photos/other";
          images = "/mnt/dpool0/media/photos";
          torrent_watch = "/mnt/dpool0/downloads/torrents";
          movies = "/mnt/dpool0/media/movies";
          audiobooks = "/mnt/dpool0/media/audiobooks";
          books = "/mnt/dpool0/media/books";
          music = "/mnt/dpool0/media/music";
          videos = "/mnt/dpool0/media/videos";
          television = "/mnt/dpool0/media/shows";

          podmanSocket = "/var/run/podman/podman.sock";
        };
      };

      secrets =
        builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");

      mkFormatters =
        systemsl: builtins.foldl'
          (output: sys: output // { ${sys} = inputs.nixpkgs.legacyPackages."${sys}".nixpkgs-fmt; })
          { }
          (nixpkgs.lib.attrValues systemsl);

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            (import ./hosts/${hostname}/configuration.nix)
          ];
          specialArgs = { inherit inputs secrets system opts; };
        };

      mkHome = pkgs: system: username:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs.legacyPackages."${system}";
          modules = [
            stylix.homeManagerModules.stylix
            ./users/${username}.nix
          ];
          extraSpecialArgs = { inherit inputs secrets system username opts; };
        };
    in
    {
      # Formatters for Nix Files
      formatter = mkFormatters systems;

      # Operating System Level Configurations 
      nixosConfigurations = {
        nullptrderef1 = mkSystem inputs.nixpkgs systems.x86 "nullptrderef1";
      };

      # User Level Home Manager Configurations
      homeConfigurations = {
        admin = mkHome inputs.nixpkgs systems.x86 "admin";
        sreedev = mkHome inputs.nixpkgs systems.x86 "sreedev";
        pi = mkHome inputs.nixpkgs systems.arm64 "pi";
      };
    };
}
