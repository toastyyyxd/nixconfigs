{ config, pkgs, ... }:
{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # BT Audio
  environment.systemPackages = with pkgs; [ bluetui ];
  services.pipewire.wireplumber.extraConfig = {
    "10-bluez" = {
      "monitor.bluez.properties" = {
        # Disable low quality codecs, such as HSP/HFP.
        "bluez5.autoswitch-profile" = false;
        "bluez5.enable-hfp" = false;
        "bluez5.enable-hsp" = false;

        "bluez5.enable-sbc-xq" = false; # Disable SBC-XQ, as it is not supported by most devices.
        "bluez5.enable-msbc" = false;
        "bluez5.enable-hw-volume" = true;
        # bluez5.codecs are all enabled by default
        "bluez5.a2dp.ldac.quality" = "hq";
      };
    };
    "11-bluetooth-policy" = {
      "wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
    };
    "soundcore-space-one-pro" = {
      "monitor.bluez.rules" = [
        {
          matches = [
            {
              "device.name" = "~bluez_sink.*";
              "device.description" = "soundcore Space One Pro";
            }
          ];
          actions = {
            update-props = {
              "bluez5.roles" = [ "a2dp_sink" ];
              "bluez5.a2dp.codecs" = [ "ldac" ];
              "bluez5.default.rate" = 192000;
              "bluez5.default.channels" = 2;
              "bluez5.default.format" = "S32LE";
            };
          };
        }
      ];
    };
    "soundcore-wakey" = {
      "monitor.bluez.rules" = [
        {
          matches = [
            {
              "device.name" = "~bluez_card.*";
              "device.description" = "Soundcore Wakey";
            }
          ];
          actions = {
            update-props = {
              "bluez5.roles" = [ "a2dp_sink" ];
              "bluez5.a2dp.codecs" = [ "sbc" ];
              "bluez5.default.rate" = 48000;
              "bluez5.default.channels" = 2;
              "bluez5.default.format" = "S16LE";
            };
          };
        }
      ];
    };
    "soundcore-rave-partycast" = {
      "monitor.bluez.rules" = [
        {
          matches = [
            {
              "device.name" = "~bluez_sink.*";
              "device.description" = "Rave PartyCast";
            }
          ];
          actions = {
            update-props = {
              "bluez5.roles" = [ "a2dp_sink" ];
              "bluez5.a2dp.codecs" = [ "sbc" ];
              "bluez5.default.rate" = 48000;
              "bluez5.default.channels" = 1;
              "bluez5.default.format" = "S16LE";
            };
          };
        }
      ];
    };
  };
}
