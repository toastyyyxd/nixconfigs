{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 5;
      gaps_out = 5;
    };
    decoration = {
      rounding = 8;
      fullscreen_opacity = 1;
      active_opacity = 0.9;
      inactive_opacity = 0.8;
      blur = {
        enabled = true;
        size = 12;
        passes = 3;
      };
    };
  };
}
