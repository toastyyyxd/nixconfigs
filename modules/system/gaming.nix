{ config, pkgs, ... }:
{
  imports = [
    ./wine.nix
  ];
  programs.firejail.enable = true; # itch.io sandboxing
  programs.gamemode.enable = true; # GameMode daemon/lib
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  environment.systemPackages = with pkgs; [
    itch
  ];
}
