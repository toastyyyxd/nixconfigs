{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    grimblast # Screenshot util.
  ];
  programs.kitty.enable = true; # Always, for use and recovery.
  
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "stay_focused on, match:class ^zoom$, match:title ^menu window$"
      "float on, match:class ^kitty$"
      "float on, match:class ^yazi$"
    ];
  };
}
