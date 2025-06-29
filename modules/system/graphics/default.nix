{ config, pkgs, ... }:
{
  imports = [
    (if builtins.match "AMD" config.hardware.gpu.vendor then ./amd.nix
     else if builtins.match "Intel" config.hardware.gpu.vendor then ./intel.nix
     else ./unknown.nix)
  ];
}
