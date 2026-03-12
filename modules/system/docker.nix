{ config, lib, pkgs, ... }:
{
  systemd.tmpfiles.rules = [ "d /home/docker 0700 root root -" ];
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "/home/docker";
    };
  };
  systemd.services.docker = {
    serviceConfig = {
      Type = lib.mkForce "exec"; # Avoid delaying boot, doesn't wait for exit
      Restart = lib.mkForce "always";  # Ensures Docker restarts if it crashes
    };
  };
}
