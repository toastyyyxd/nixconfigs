{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    dune3d
  ];
}
