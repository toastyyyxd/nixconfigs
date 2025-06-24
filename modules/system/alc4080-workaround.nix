{ config, pkgs, ... }:
{
  # Prevent early loading of the USB audio module.
  boot.blacklistedKernelModules = [ "snd-usb-audio" ];

  # Define the systemd service that loads the USB audio module
  systemd.services."load-snd-usb-audio" = {
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];
    script = ''
      # Run modprobe to manually load the snd-usb-audio module
      ${pkgs.kmod}/bin/modprobe snd-usb-audio
    '';
    serviceConfig = {
      Type = "exec";  # Ensures the service runs once, and the boot continues on fork, without waiting for exiting
      User = "root";  # Run the service with root privileges to ensure module loading works
    };
  };
}
