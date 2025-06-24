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
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    overlays = [
      (_: _: { tidaluna = inputs.tidaluna.packages.x86_64-linux.default; })
      inputs.nix-vscode-extensions.overlays.default
      (_: _: { wiremix = inputs.wiremix.packages.x86_64-linux.default; })
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
        };
        modules = [
          ./hosts/desktop/configuration.nix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.default
          {
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
        };
        modules = [
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
