{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    flatpak
  ];
  systemd.user.services.flatpak-repos = {
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
    Service = {
      ExecStart = ''
        ${pkgs.flatpak}/bin/flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
    Unit = {
      Description = "Add flatpak repos";
    };
  };
}
