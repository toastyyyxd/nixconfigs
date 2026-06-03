{ pkgs, config, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [ brlaser ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.sane = {
    enable = true;
    brscan4 = {
      enable = true;
      netDevices = {
        home = { model = "MFC-L2700DW"; ip = "192.168.1.22"; };
      };
    };
  };
}
