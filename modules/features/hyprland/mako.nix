{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      layer = "overlay";
      default-timeout = 10000;
    };
  };
}
