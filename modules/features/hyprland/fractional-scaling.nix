
# Fractional scaling support for Electron apps (VSCode, Discord, etc.)
{ config, pkgs, ... }:
{

  # Set environment variables globally for all Home Manager sessions
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };
}
