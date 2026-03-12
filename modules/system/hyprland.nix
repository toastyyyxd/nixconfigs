{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [ ];
  services.greetd.settings.default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd hyprland";
  services.greetd.settings.initial_session.command = "hyprland";
}
