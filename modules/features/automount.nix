{ config, lib, pkgs, ... }:
{
  services.udiskie = {
    enable = true;
    settings = {
      automount = true;
      notify = true;
      program_options = {
        file_manager = "${pkgs.yazi}/bin/yazi";
      };
    };
  };
}