{ inputs, configs, pkgs, ... }:
{
  services.thermald.enable = true; # Prevent overheating
  programs.auto-cpufreq = {
    enable = true;
    settings = {};
  };
}
