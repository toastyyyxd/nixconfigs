{ config, pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa-vulkan-drivers
        vulkan-tools
        mesa-utils
      ];
    };
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };
}
