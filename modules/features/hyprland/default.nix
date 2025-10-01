{ config, pkgs, ... }:
{
  imports = [
    ./programs.nix # Dependencies & compatibility.
    ./styling.nix # Styling & decor.
    ../ux/wallpaper.nix # swww & waypaper.
    ../ux/mako.nix # Notifications.
    ../ux/fuzzel.nix # App launcher.
    ./workspace-binds.nix # Generated keybinds to move and goto workspaces.
    ./binds.nix # Key & mouse bindings.
    ./media-controls.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
