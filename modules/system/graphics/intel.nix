{ config, pkgs, ... }:
{
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [
    "i915.enable_guc=3"
    "i915.enable_guc_loading=1"
    "i915.enable_psr=1" # Enable Panel Self Refresh for power saving
  ];

  hardware.graphics = {
    enable = true;             # Enable Mesa's OpenGL stack
    enable32Bit = true;        # 32-bit apps on 64-bit OS
    extraPackages = with pkgs; [
      intel-media-driver       # VA-API / VPG driver for Xe
      intel-gpu-tools          # Debugging and performance tools
    ];
  };
}
