{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    layer = "overlay";
    defaultTimeout = 10000;
  };
}
