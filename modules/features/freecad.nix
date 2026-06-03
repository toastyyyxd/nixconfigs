{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    freecad
    gmsh
    calculix-ccx
    git
  ];
}
