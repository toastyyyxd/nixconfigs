{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    waypaper
  ];
  services.awww.enable = true;
  wayland.windowManager.hyprland.settings = {
    exec-once = [ "waypaper --restore" ];
  };
}

