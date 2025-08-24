{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
  ];
  wayland.windowManager.hyprland.settings = {
    "$cmd_setmute" = "wpctl set-mute @DEFAULT_AUDIO_SINK@";
    "$cmd_setvol" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ -l 1.0";
    "$cmd_setvol_boost" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ -l 1.5";
    bind = [
      ", XF86AudioRaiseVolume, exec, $cmd_setmute 0 && $cmd_setvol 5%+"
      ", XF86AudioLowerVolume, exec, $cmd_setmute 0 && $cmd_setvol 5%-"
      ", XF86AudioMute, exec, $cmd_setmute toggle"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"

      "$mod, XF86AudioRaiseVolume, exec, $cmd_setmute 0 && $cmd_setvol_boost 5%+"
      "$mod, XF86AudioLowerVolume, exec, $cmd_setmute 0 && $cmd_setvol_boost 5%-"
    ];
  };
}
