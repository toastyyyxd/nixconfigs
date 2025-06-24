{ config, pkgs, ... }:
{
  services.journald = {
    storage = "volatile";
    rateLimitBurst = 0;
    rateLimitInterval = "0s";
    extraConfig = ''
SystemMaxUse=48M
RuntimeMaxUse=32M
LogLevelMax=info
    '';
  };
}
