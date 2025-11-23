{
  services.pipewire = {
    extraConfig.pipewire."context.modules" = [
      {
        name = "libpipewire-module-loopback";
        args = {
          node.name = "virtual_5_1";
          audio.channels = 6;
          audio.position = [ "FL" "FR" "RL" "RR" "FC" "LFE" ];
          media.class = "Audio/Sink";
        };
      }
    ];
  };
}
