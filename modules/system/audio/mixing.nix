{
  services.pipewire = {
    extraConfig.pipewire = {
        # Device A: stereo (front + center mix)
        {
          name = "libpipewire-module-null-audio-sink";
          args = {
            node.name = "device_A";
            audio.channels = 2;
            audio.position = [ "FL" "FR" ];
            media.class = "Audio/Sink";
            device.description = "Device A (Front + Center)";
            node.latency_offset = 50;   # adjust experimentally
          };
        }

        # Device B: stereo (sub + rears mix, but treated as mono)
        {
          name = "libpipewire-module-null-audio-sink";
          args = {
            node.name = "device_B";
            audio.channels = 2;
            audio.position = [ "FL" "FR" ];
            media.class = "Audio/Sink";
            device.description = "Device B (Sub + Rears)";
            node.latency_offset = 120;  # adjust experimentally
          };
        }

        # Mixer nodes for routing
        {
          name = "libpipewire-module-audiomixer";
          args = {
            node.name = "mix_A_FL";
            inputs = [ "virtual_5_1:FL" "virtual_5_1:FC" ];
            outputs = [ "device_A:FL" ];
          };
        }
        {
          name = "libpipewire-module-audiomixer";
          args = {
            node.name = "mix_A_FR";
            inputs = [ "virtual_5_1:FR" "virtual_5_1:FC" ];
            outputs = [ "device_A:FR" ];
          };
        }
        {
          name = "libpipewire-module-audiomixer";
          args = {
            node.name = "mix_B";
            inputs = [ "virtual_5_1:LFE" "virtual_5_1:RL" "virtual_5_1:RR" ];
            outputs = [ "device_B:FL" "device_B:FR" ];
          };
        }
      ];
    };
  };
}
