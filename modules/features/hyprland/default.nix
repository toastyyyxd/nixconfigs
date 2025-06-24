{ config, pkgs, ... }:
{
  imports = [
    ./programs.nix # Dependencies & compatibility.
    ./styling.nix # Styling & decor.
    ./wallpaper.nix # swww & waypaper.
    ./waybar.nix # Bar
    ./mako.nix # Notifications.
    ./fuzzel.nix # App launcher.
    ./workspace-binds.nix # Generated keybinds to move and goto workspaces.
    ./binds.nix # Key & mouse bindings.
    ./media-controls.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
