{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Keybindings
    bind = [
      "$mod, mouse_up, workspace, e+1" # Scroll to next workspace.
      "$mod, mouse_down, workspace, e-1" # Scroll to previous workspace.
    ] # Generate keybindings to move and go to workspaces
    ++ (
      builtins.concatLists (builtins.genList (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      )
      9)
    );
  };
}
