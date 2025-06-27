{ config, pkgs, ... }:
{
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [
    "i915.enable_guc=3"
    "i915.enable_guc_loading=1"
  ];

  hardware.graphics = {
    enable = true;             # enable Mesa’s OpenGL stack
    enable32Bit = true;    # 32-bit apps on 64-bit OS
    extraPackages = with pkgs; [
      intel-media-driver       # newer VA-API / VPG driver for Xe
    ];
  };
}
