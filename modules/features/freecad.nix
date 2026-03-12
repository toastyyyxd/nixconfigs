{ config, pkgs, ... }:

let
  freecadOverlay = final: prev: {
    freecad = (import (pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "f6335dd4a0bb96de60bc8131510147929f2c325f";
      sha256 = "sha256-x/P3PbUcQ6X9785uV569EiwRreZoVsVYbm00Bj4DNcg=";
    }) {
      # Explicitly set the local system to match the current stdenv host platform
      localSystem = final.stdenv.hostPlatform;
    }).freecad;
  };

  customPkgs = import pkgs.path {
    inherit (pkgs) system;
    overlays = [ freecadOverlay ];
  };
in {
  home.packages = with customPkgs; [
    freecad
    gmsh
    calculix-ccx
    git
  ];
}
