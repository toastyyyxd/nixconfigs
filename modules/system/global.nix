{ config, pkgs, ... }:
{
  home-manager.backupFileExtension = "hm-backup"; # Set home-manager backup file extension.
  services.xserver.libinput.touchpad.disableWhileTyping = false;
}
