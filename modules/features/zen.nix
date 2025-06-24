{ config, pkgs, inputs, ... }:

{
  # Zen Browser configuration
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".beta # Zen Browser (flake)
  ];
}
