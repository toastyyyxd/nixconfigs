{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    evtest
  ];
}
