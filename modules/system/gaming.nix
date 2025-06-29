{ config, pkgs, ... }:
{
  imports = [
    ./wine.nix  4
  ];
  programs.firejail.enable = true; # itch.io sandboxing
  programs.gamemode.enable = true; # GameMode daemon/lib
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    itch
  ];
}
