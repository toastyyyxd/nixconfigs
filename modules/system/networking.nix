{ config, pkgs, ... }: 
{
  # Use networkmanager.
  # NixOS's native functionality needs too much
  # manual work.
  # You can predefine some networks that will
  # persist between rebuilds.
  networking.wireless.userControlled.enable = true;

  networking.networkmanager.enable = true;
  systemd.services."NetworkManager-wait-online".enable = false; # Prevent blocking boot.

  # DNS
  networking.networkmanager.dns = "none"; # Managing DNS thru Nix.
  networking.useDHCP = false; # DHCP isn't needed when managing DNS ourselves.
  networking.dhcpcd.enable = false;
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "9.9.9.9"
  ];

  # Ensure performance over power efficiency.
  networking.networkmanager.wifi.powersave = false;

  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      8000 # SillyTavern
    ]; 
  }; 
}
