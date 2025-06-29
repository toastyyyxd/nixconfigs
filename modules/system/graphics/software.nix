{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;             # Enable Mesa's OpenGL stack
    enable32Bit = true;        # Support for 32-bit applications
    extraPackages = with pkgs; [
      mesa-utils              # Basic OpenGL utilities
      vulkan-tools            # Vulkan debugging tools
      swrast                 # Fallback software rasterizer
    ];
  };

  environment.systemPackages = with pkgs; [
    glxinfo                  # OpenGL information tool
    vulkaninfo               # Vulkan information tool
    xrandr                   # Display configuration tool
  ];
}
