{ config, pkgs, ... }:
{
  services.cloudflare-warp.enable = true;
  networking.nftables.tables.nixos-fw = {
    name = "nixos-fw";
    family = "inet";
    content = ''
      chain rpfilter-allow {
        iifname "CloudflareWARP" accept
      }
      chain rpfilter-allow {
        # WARP WireGuard endpoints (return traffic arrives here)
        ip saddr 162.159.193.0/24 udp sport 2408 accept
        ip6 saddr 2606:4700:100::/48 udp sport 2408 accept
        ip saddr 162.159.197.0/24 udp sport 443 accept
        ip6 saddr 2606:4700:102::/48 udp sport 443 accept
        ip saddr 162.159.197.0/24 tcp sport 443 accept
        ip6 saddr 2606:4700:102::/48 tcp sport 443 accept
        ip saddr { 162.159.137.105, 162.159.138.105 } tcp sport 443 accept
        ip6 saddr { 2606:4700:7::a29f:8969, 2606:4700:7::a29f:8a69 } tcp sport 443 accept
        ip saddr { 162.159.36.1, 162.159.46.1 } tcp sport 443 accept
        ip6 saddr { 2606:4700:4700::1111, 2606:4700:4700::1001 } tcp sport 443 accept
        ip saddr 162.159.198.2 accept
        ip6 saddr 2606:4700:103::2 accept
      }
    '';
  };
}
