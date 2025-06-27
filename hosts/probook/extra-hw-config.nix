{ config, pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [
      "iwlwifi" "iwlmvm" # Wifi
      "r8169" "rtsx_pci" # sdcard reader
    ];
    initrd.availableKernelModules = [
      "r8169"
      "rtsx_pci"
    ];
    blacklistedKernelModules = [ "r8188eu" ]; # prevents conflicts
  };

  hardware = { # general
    enableRedistributableFirmware = true;
    firmware = with pkgs; [ firmwareLinuxNonfree ];
  };
}
