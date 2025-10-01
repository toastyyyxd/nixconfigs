{ config, lib, pkgs, ... }:
{
  # My samsung t9 has trouble with UAS when writing.
  boot.kernelParams = [ "usb-storage.quirks=04e8:61fd:u" ];
  services.udisks2.enable = true; # make sure to use udiskie in home-manager to enable automount
}