{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "toasty";
  home.homeDirectory = "/home/toasty";

  # Import modules
  imports = [
    ../../modules/features/hyprland
    ../../modules/features/yazi.nix
    ../../modules/features/flatpak.nix
    ../../modules/features/git.nix
    ../../modules/features/nvim.nix
    ../../modules/features/vscode.nix
    ../../modules/features/prismlauncher.nix
    ../../modules/features/tidal-hifi.nix
    ../../modules/features/dune3d.nix
    ../../modules/features/libreoffice.nix
    ../../modules/features/kicad.nix
    ../../modules/features/zen.nix
  ];

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
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
