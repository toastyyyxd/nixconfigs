{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swww
    waypaper
  ];
  systemd.user.services.swww = {
    Unit = {
      Description = "SWWW Simple Wayland Wallpaper daemon";
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
  wayland.windowManager.hyprland.settings = {
    exec-once = [ "waypaper --restore" ];
  };
}

