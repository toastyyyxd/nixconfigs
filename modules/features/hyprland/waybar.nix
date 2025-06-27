{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    powerline-fonts
    font-awesome
  ];
  fonts.fontconfig.enable = true;

  catppuccin.waybar.mode = "prependImport";
  programs.waybar = {
    enable = true;
    style = ''
@import "/etc/nixos/modules/features/hyprland/waybar.css";
'';
    settings = {
      mainBar = {
        layer = "overlay";
        position = "top";
        exclusive = false;
        start_hidden = true;
        modules-left = [ "clock" "hyprland/workspaces" ];
        modules-center = [ "custom/music" ];
        modules-right = [ "tray" "cpu" "memory" "battery" ];
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
        "custom/music" = {
          format = "  {}";
          escape = true;
          interval = 5;
          tooltip = false;
          exec = "playerctl metadata --format='{{ title }} | {{ artist }}'";
          on-click = "playerctl play-pause";
          max-length = 70;
        };
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "  {:%d/%m/%Y}";
          format = "  {:%H:%M}";
        };
      };
    };
  };
  wayland.windowManager.hyprland.settings = {
    exec-once = [ "waybar" ];
    bindit = [ "$mod, SUPER_L, exec, pkill -SIGUSR1 waybar" ];
    bindirt = [ "$mod, SUPER_L, exec, pkill -SIGUSR1 waybar" ];  
  };
}
