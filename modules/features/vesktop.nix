{ config, pkgs, ... }:
{
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "stable";
      transparencyOption = "mica";
      tray = false;
      minimizeToTray = true;
      autoStartMinimized = false;
      openLinksWithElectron = false;
      staticTitle = true;
      enableMenu = true;
      disableSmoothScroll = false;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      arRPC = true;
      appBadge = false;
      enableTaskbarFlashing = false;
      disableMinSize = true;
      clickTrayToShowHide = false;
      customTitleBar = false;
      enableSplashScreen = false;
    };
  };
}
