{ config, pkgs, inputs, ... }:

{
  # Zen Browser configuration
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".twilight # Zen Browser (flake)
  ];
}
