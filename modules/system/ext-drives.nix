{ config, lib, pkgs, ... }:
{
  services.udisks2.enable = true; # make sure to use udiskie in home-manager to enable automount
}
