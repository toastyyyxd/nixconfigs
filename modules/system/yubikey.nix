{ config, pkgs, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  environment.systemPackages = with pkgs; [
    libfido2
    yubico-pam
    yubikey-manager
    yubico-piv-tool
    yubioath-flutter
  ];
}
