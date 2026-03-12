{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    stress s-tui stress-ng lm_sensors
    btop numactl i2c-tools dmidecode
  ];
}
