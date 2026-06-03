{ config, pkgs, inputs, ... }:

{
  home.username = "toasty";
  home.homeDirectory = "/home/toasty";

  imports = [
    ../../modules/features/nvim.nix
    ../../modules/features/git.nix
  ];

  home.packages = with pkgs; [];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
