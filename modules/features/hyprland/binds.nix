{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER"; # Set MOD key to SUPER
    
    # Keybindings
    bind = [
      "$mod, X, killactive"                # Close window
      "$mod, T, exec, kitty"               # Open terminal
      "$mod, E, exec, kitty -e yazi"       # Open files
      "$mod, W, exec, zen-beta"                 # Open browser
      "$mod, Q, exec, fuzzel"              # Application selector
      "$mod, M, exec, tidal-hifi"          # Music
      "$mod, V, togglefloating"
      ", Print, exec, grimblast copy area" # Screenshot
    ];
    
    # Mousebindings
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
