{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    grimblast # Screenshot util.
  ];
  programs.kitty.enable = true; # Always, for use and recovery.
  
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "stayfocused,class:(zoom),initialTitle:(menu window)" # Zoom fix
      "float,class:(kitty)" # Float terminal by default
      "float,class:(yazi)" # Float file explorer by default
    ];
  };
}
