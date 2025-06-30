{ config, pkgs, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  environment.systemPackages = with pkgs; [
    libfido2
    yubico-pam
    yubikey-manager
    yubico-piv-tool
    pcscd yubioath-flutter
  ];
}
