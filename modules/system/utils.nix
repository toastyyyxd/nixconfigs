{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    tree
    evtest
  ];
}
