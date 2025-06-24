{ config, pkgs, ... }:

{
  imports = [
    ../../modules/system/global.nix
    ../../modules/system/journald.nix
    ../../modules/system/ssh.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/networking.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/utils.nix
    inputs.home-manager.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "probook";
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_HK.UTF-8";

  users.users.toasty = {
    isNormalUser = true;
    description = "toasty";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "toasty" = import ./home.nix;
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        user = "toasty";
      };
    };
  };

  # Basic system settings
  system.stateVersion = "24.11"; # Adjust to your NixOS version

  # Add any device-specific configurations here
}
