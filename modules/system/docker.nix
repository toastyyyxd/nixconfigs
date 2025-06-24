{ config, lib, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  systemd.services.docker = {
    serviceConfig = {
      Type = lib.mkForce "exec"; # Avoid delaying boot, doesn't wait for exit
      Restart = lib.mkForce "always";  # Ensures Docker restarts if it crashes
    };
  };
}
