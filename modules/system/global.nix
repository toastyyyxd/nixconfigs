{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  home-manager.backupFileExtension = "hm-backup"; # Set home-manager backup file extension.
  services.libinput.touchpad.disableWhileTyping = false;
}
