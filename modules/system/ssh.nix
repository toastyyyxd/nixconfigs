{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ openssl ];
  programs.ssh = {
    startAgent = false;
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
