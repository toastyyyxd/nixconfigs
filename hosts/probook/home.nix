{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "toasty";
  home.homeDirectory = "/home/toasty";

  # Import modules
  imports = [
    ../../modules/features/hyprland
    ../../modules/features/hyprland/fractional-scaling.nix
    ../../modules/features/yazi.nix
    ../../modules/features/flatpak.nix
    ../../modules/features/git.nix
    ../../modules/features/nvim.nix
    ../../modules/features/vscode.nix
    ../../modules/features/prismlauncher.nix
    ../../modules/features/tidal-hifi.nix
    ../../modules/features/libreoffice.nix
    ../../modules/features/zen.nix
    ../../modules/features/gimp.nix
  ];

  # Display scaling
  wayland.windowManager.hyprland.settings = {
    monitor = [ "eDP-1,1920x1080@60.00200,0x0,1.25" ];
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    wget
    hyfetch # Neofetch
    s-tui stress
    vesktop # Vencord desktop - Discord
    orca-slicer
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
