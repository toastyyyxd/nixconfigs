{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  catppuccin.vscode.profiles.main = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    settings = {
      boldKeywords = true;
      italicComments = true;
      italicKeywords = true;
      extraBordersEnabled = false;
      workbenchMode = "default";
      bracketMode = "rainbow";
    };
    icons = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 5;
      gaps_out = 5;
    };
    decoration = {
      rounding = 8;
      fullscreen_opacity = 1;
      active_opacity = 1;
      inactive_opacity = 0.85;
      blur = {
        enabled = true;
        size = 12;
        passes = 3;
      };
    };
  };
}
