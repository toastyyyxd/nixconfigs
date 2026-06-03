{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tidaluna.url = "github:Inrixia/TidaLuna";
    wiremix.url = "github:tsowell/wiremix";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixowos.url = "github:yunfachi/nixowos/638ec8eaecbfecdeebba5d1cbe75b070f7825817";
    affinity.url = "github:mrshmllow/affinity-nix";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, ... }@inputs: let

    overlays = [
      (final: _: { tidaluna = inputs.tidaluna.packages.${final.stdenv.hostPlatform.system}.default; })
      inputs.nix-vscode-extensions.overlays.default
      (final: _: { wiremix = inputs.wiremix.packages.${final.stdenv.hostPlatform.system}.default; })
      inputs.affinity.overlays.default
      (import ./overlays/openldac.nix)
    ];
    globalConfig = [
      inputs.nixowos.nixosModules.default
      {
        nixowos.enable = true;
      }
    ];
  in {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = overlays;
          config.permittedInsecurePackages = [
            "libsoup-2.74.3" # for orcaslicer
          ];
        };
        modules = globalConfig ++ [
          ./hosts/desktop/configuration.nix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.default
          {
            nixpkgs.overlays = overlays;
            home-manager.useGlobalPkgs = true;
          }
        ];
      };
      probook = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = overlays;
          config.permittedInsecurePackages = [
            "libsoup-2.74.3" # for orcaslicer
          ];
        };
        modules = globalConfig ++ [
          ./hosts/probook/configuration.nix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
          }
        ];
      };
    };
  };
}
