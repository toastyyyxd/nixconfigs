{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    signing.format = "ssh";
    settings = {
      user = {
        email = "contact@toastyx.dev";
        name = "toastyyyxd";
      };
    };
  };
}
