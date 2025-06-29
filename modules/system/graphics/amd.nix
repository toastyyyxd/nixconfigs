{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      driversi686Linux.amdvlk
      rocmPackages.clr.icd
    ];
  };
  hardware.opengl = {
    driSupport32Bit = true;
  };
}
