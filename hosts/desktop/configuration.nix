{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Import essentials and system modules.
      ./hardware-configuration.nix # Auto generated from the hardware scan, do not modify!
      ../../modules/system/global.nix
      ../../modules/system/journald.nix
      ../../modules/system/ssh.nix ../../modules/system/yubikey-ssh.nix
      ../../modules/system/yubikey.nix
      ../../modules/system/keyboard.nix
      ../../modules/system/networking.nix # Network configurations.
      ../../modules/system/bluetooth.nix
      ../../modules/system/openrgb.nix # ARGB lights.
      ../../modules/system/audio.nix ../../modules/system/alc4080-workaround.nix # Audio & workaround for slow boot with ALC4080 USB audio chip.
      ../../modules/system/graphics/amd.nix
      ../../modules/system/hyprland.nix # NixOS module for hyprland.
      ../../modules/system/docker.nix
      ../../modules/system/wine.nix
      ../../modules/system/gaming.nix
      ../../modules/system/sim-driving.nix
      ../../modules/system/adb.nix
      ../../modules/system/utils.nix
      inputs.home-manager.nixosModules.default # Home manager.
    ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Set resolutions on boot before display drivers are loaded.
  boot.kernelParams = [ "video=1920x1080" ];  
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.

  # Set timezone and localization.
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_HK.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  # Enable automatic login for the user.
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        user = "toasty";
      };
    };
  };

  # Install essential system packages here,
  # most packages should be installed via home.nix or modules
  environment.systemPackages = with pkgs; [];

  # List services that you want to enable:
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
