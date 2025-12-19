{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    stress s-tui stress-ng
    btop numactl i2c-tools dmidecode
  ];
}