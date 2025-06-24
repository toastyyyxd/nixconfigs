{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg vlc ];
    })
  ];
}
