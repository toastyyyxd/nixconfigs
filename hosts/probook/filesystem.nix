{ config, pkgs, ... }:
{
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2169-D0A5";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services."trigger-partprobe" = {
    unitConfig = {
      After = "systemd-cryptsetup@cryptroot.service";  # ✅ Correct: Runs after LUKS unlock
      Requires = "systemd-cryptsetup@cryptroot.service"; # ✅ Hard dependency
      Before = [ 
        "initrd-switch-root.target"  # ✅ Final initrd step
        "sysroot.mount"             # ✅ Root mount
        "systemd-hibernate-resume.service" # ✅ Critical for resume
      ];
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/partprobe /dev/mapper/cryptroot";
    };
    wantedBy = [ "initrd.target" ];
  };
  boot.initrd.systemd.services."systemd-hibernate-resume".unitConfig = {
    After = ["cryptroot-probe.service"];
    Requires = ["cryptroot-probe.service"];
  };

  boot.initrd.systemd.extraBin = {
    parted = "${pkgs.parted}/bin/parted";
    partprobe = "${pkgs.parted}/bin/partprobe";
  };

  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-uuid/6fdee1e0-a160-42fc-9983-54425c377478";
  };
    # 2) Force the right kernel modules into the initrd
  #    so that dm_crypt is available at early-boot
  boot.initrd.kernelModules = [ 
    "usb_storage" "uas" "nvme" "sd_mod" "xhci_pci" # USB
    "dm_mod" "dm_crypt" "aes_generic" "aesni_intel"  "xts" "sha256"
    "btrfs" "zstd"
  ];
  fileSystems."/" = {
    device = "/dev/mapper/cryptroot1";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" "ssd" ];
  };
  fileSystems."/home" = {
    device = "/dev/mapper/cryptroot1";
    fsType = "btrfs";
    options = [ "subvol=home" "compress=zstd" "noatime" "ssd" ];
  };
  fileSystems."/nix" = {
    device = "/dev/mapper/cryptroot1";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" "ssd" ];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/340586a6-d845-413c-b0c6-f939c9e669d1";
      randomEncryption.enable = false;
      discardPolicy = "both";
    }
  ];
  boot.kernelParams = [ "resume=/dev/disk/by-uuid/340586a6-d845-413c-b0c6-f939c9e669d1" ];
  boot.resumeDevice = "/dev/disk/by-uuid/340586a6-d845-413c-b0c6-f939c9e669d1";
}
