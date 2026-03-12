{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "contact@toastyx.dev";
        name = "toastyyyxd";
      };
    };
  };
}
