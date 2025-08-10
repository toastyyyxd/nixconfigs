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

        "bluez5.enable-sbc-xq" = true;
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
    "soundcore-wakey" = {
      "monitor.bluez.rules" = [
        {
          matches = [
            {
              # Match any bluetooth device with ids equal to that of a Soundcore Wakey
              "device.name" = "~bluez_card.*";
              "device.description" = "Soundcore Wakey";
            }
          ];
          actions = {
            update-props = {
              # Set the device to use the LDAC codec
              "bluez5.roles" = [ "a2dp_sink" ];
              "bluez5.a2dp.codecs" = [ "aac" "aptx" "aptx_hd" "ldac" ];
              # Set quality to high quality instead of the default of auto
              "bluez5.a2dp.ldac.quality" = "hq";
              "bluez5.default.rate" = 192000;
              "bluez5.default.channels" = 2;
              "bluez5.default.format" = "S32LE";
            };
          };
        }
      ];
    };
  };
  environment.etc = {
    "wireplumber/bluetooth.lua.d/50-auto-switch-bluetooth.lua".text =
      ''
        -- Global flag to track if a Bluetooth device is currently set as default
        local bluetooth_default = false

        -- Helper function: mark a node as the default sink.
        local function set_default_sink(node)
          if node then
            node:set_property("default.audio.sink", true)
            log.info("Set default audio sink to: " ..
              (node.properties["node.name"] or "unknown"))
          end
        end

        -- Called whenever a new node is added.
        local function on_node_added(node)
          local name = node.properties["node.name"] or ""
          if name:find("bluez") then
            set_default_sink(node)
            bluetooth_default = true
          end
        end

        -- Called whenever a node is removed.
        local function on_node_removed(node)
          local name = node.properties["node.name"] or ""
          -- Only react if a Bluetooth node that was our default is removed
          if name:find("bluez") and bluetooth_default then
            bluetooth_default = false
            -- Attempt to find a fallback: any available node that does NOT include "bluez"
            for _, n in ipairs(object.list("node")) do
              local n_name = n.properties["node.name"] or ""
              if not n_name:find("bluez") then
                set_default_sink(n)
                break
              end
            end
          end
        end

        object.observe("node-added", on_node_added)
        object.observe("node-removed", on_node_removed)
      '';
  };
}
