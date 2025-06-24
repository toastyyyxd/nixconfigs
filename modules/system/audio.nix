{ config, pkgs, ... }:
{
  services.pulseaudio.enable = false; # use pipewire.

  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [ wiremix ];
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 192000;
        "default.clock.quantum" = 16;
        "default.clock.min_quantum" = 16;
        "default.clock.max_quantum" = 256;
      };
    }; 
    extraConfig.pipewire-pulse."92-low-latency" = {
      "context.properties" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = { };
        }
      ];
      "pulse.properties" = {
        "pulse.min.req" = "16/192000";
        "pulse.default.req" = "16/192000";
        "pulse.max.req" = "256/192000";
        "pulse.min.quantum" = "16/192000";
        "pulse.max.quantum" = "256/192000";
      };
      "stream.properties" = {
        "node.latency" = "16/192000";
        "resample.quality" = 1;
      };
    };
  };
}
