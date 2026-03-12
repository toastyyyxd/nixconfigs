{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg vlc ];
    })
    javaPackages.compiler.temurin-bin.jre-25
  ];
}
