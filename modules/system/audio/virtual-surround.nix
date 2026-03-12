{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    pkgs.lsp-plugins pkgs.lv2
  ];
  services.pipewire = {
    extraLv2Packages = [
      pkgs.lsp-plugins
    ];
    extraConfig.pipewire."10-virtual-surround" = {
      "stream.properties" = {
        "default.channels" = 6;
        "default.channel-map" = [ "FL" "FR" "FC" "LFE" "RL" "RR" ];
      };
      # --- 1) Virtual sinks: input and expanded output ---
      "context.objects" = [
        {
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "virtual_5_1";
            "node.description" = "Virtual 5.1";
            "media.class" = "Audio/Sink";
            "audio.channels" = 6;
            "audio.position" = [ "FL" "FR" "FC" "LFE" "RL" "RR" ];
            "stream.dont_remix" = true;
          };
        }
        {
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "virtual_5_1_expanded";
            "node.description" = "Virtual 5.1 (Expanded)";
            "media.class" = "Audio/Sink";
            "audio.channels" = 6;
            "audio.position" = [ "FL" "FR" "FC" "LFE" "RL" "RR" ];
            "stream.dont_remix" = true;
          };
        }
      ];

      # --- 2) Filter-chains wired between the two sinks and then to speakers ---
      "context.modules" = [
        # [A] Expander: capture from virtual_5_1 monitor, play to virtual_5_1_expanded
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.name" = "global_expander_filter";
            "node.description" = "Global 5.1 Expander";

            "filter.graph" = {
              "nodes" = [
                { "type" = "lv2"; "name" = "exp";  "plugin" = "http://lsp-plug.in/plugins/lv2/expander_stereo"; "control" = { "al" = 0.0316; "er" = 1.3; "at" = 5.0; "rt" = 50.0; }; }
                { "type" = "lv2"; "name" = "exp2"; "plugin" = "http://lsp-plug.in/plugins/lv2/expander_stereo"; "control" = { "al" = 0.0316; "er" = 1.3; "at" = 5.0; "rt" = 50.0; }; }
                { "type" = "lv2"; "name" = "exp3"; "plugin" = "http://lsp-plug.in/plugins/lv2/expander_stereo"; "control" = { "al" = 0.0316; "er" = 1.3; "at" = 5.0; "rt" = 50.0; }; }
              ];
              "inputs"  = [ "exp:in_l" "exp:in_r" "exp2:in_l" "exp2:in_r" "exp3:in_l" "exp3:in_r" ];
              "outputs" = [ "exp:out_l" "exp:out_r" "exp2:out_l" "exp2:out_r" "exp3:out_l" "exp3:out_r" ];
            };

            # Capture the upstream virtual sink monitor
            "capture.props" = {
              "target.object" = "virtual_5_1";
              "stream.capture.sink" = true;
              "node.autoconnect" = true;

              "audio.channels" = 6;
              "audio.position" = [ "FL" "FR" "FC" "LFE" "RL" "RR" ];
              "stream.dont_remix" = true;
            };

            # Playback into the downstream virtual sink
            "playback.props" = {
              "target.object" = "virtual_5_1_expanded";
              "node.autoconnect" = true;

              "audio.channels" = 6;
              "audio.position" = [ "FL" "FR" "FC" "LFE" "RL" "RR" ];
              "stream.dont_remix" = true;
            };
          };
        }

        # [B] Left branch: capture expanded monitor, play to Speaker A (left)
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.name" = "mix_A_Left";
            "node.description" = "Branch A Left";

            "filter.graph" = {
              "nodes" = [
                { "type" = "builtin"; "name" = "mix"; "label" = "mixer";
                  # Scaled by 0.6 to prevent clipping (1.0+1.0+0.2 = 2.2 peak -> safe at 1.32)
                  "control" = { "Gain 1" = 0.6; "Gain 2" = 0.0; "Gain 3" = 0.6; "Gain 4" = 0.0; "Gain 5" = 0.12; "Gain 6" = 0.0; };
                }
                { "type" = "builtin"; "name" = "del"; "label" = "delay"; "config" = { "max-delay" = 1.0; }; "control" = { "Delay (s)" = 0.02; }; }
              ];
              "links"   = [ { "output" = "mix:Out"; "input" = "del:In"; } ];
              "inputs"  = [ "mix:In 1" "mix:In 2" "mix:In 3" "mix:In 4" "mix:In 5" "mix:In 6" ];
              "outputs" = [ "del:Out" ];
            };

            "capture.props" = {
              "target.object" = "virtual_5_1_expanded";
              "stream.capture.sink" = true;
              "node.autoconnect" = true;

              "audio.channels" = 6;
              "audio.position" = [ "FL" "FR" "FC" "LFE" "RL" "RR" ];
              "stream.dont_remix" = true;
            };

            "playback.props" = {
              "target.object" = "bluez_output.AC_B1_EE_94_78_19.1";
              "node.autoconnect" = true;

              "audio.channels" = 1;
              "audio.position" = [ "FL" ];
              "stream.dont_remix" = true;
            };
          };
        }

        # [C] Right branch
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.name" = "mix_A_Right";
            "node.description" = "Branch A Right";

            "filter.graph" = {
              "nodes" = [
                { "type" = "builtin"; "name" = "mix"; "label" = "mixer";
                  # Scaled by 0.6 to prevent clipping (1.0+1.0+0.2 = 2.2 peak -> safe at 1.32)
                  "control" = { "Gain 1" = 0.0; "Gain 2" = 0.6; "Gain 3" = 0.6; "Gain 4" = 0.0; "Gain 5" = 0.0; "Gain 6" = 0.12; };
                }
                { "type" = "builtin"; "name" = "del"; "label" = "delay"; "config" = { "max-delay" = 1.0; }; "control" = { "Delay (s)" = 0.02; }; }
              ];
              "links"   = [ { "output" = "mix:Out"; "input" = "del:In"; } ];
              "inputs"  = [ "mix:In 1" "mix:In 2" "mix:In 3" "mix:In 4" "mix:In 5" "mix:In 6" ];
              "outputs" = [ "del:Out" ];
            };

            "capture.props" = {
              "target.object" = "virtual_5_1_expanded";
              "stream.capture.sink" = true;
              "node.autoconnect" = true;

              "audio.channels" = 6;
              "audio.position" = [ "FL" "FR" "FC" "LFE" "RL" "RR" ];
              "stream.dont_remix" = true;
            };

            "playback.props" = {
              "target.object" = "bluez_output.AC_B1_EE_94_78_19.1";
              "node.autoconnect" = true;

              "audio.channels" = 1;
              "audio.position" = [ "FR" ];
              "stream.dont_remix" = true;
            };
          };
        }

        # [D] Sub/mid branch
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.name" = "mix_B_Sub";
            "node.description" = "Branch B Sub/Mid";

            "filter.graph" = {
              "nodes" = [
                { "type" = "builtin"; "name" = "cFL"; "label" = "copy"; }
                { "type" = "builtin"; "name" = "cFR"; "label" = "copy"; }
                { "type" = "builtin"; "name" = "cFC"; "label" = "copy"; }

                { "type" = "builtin"; "name" = "m_lpf"; "label" = "mixer";
                  # Scaled by 0.7 to prevent clipping in summed low-pass path
                  "control" = { "Gain 1" = 0.56; "Gain 2" = 0.56; "Gain 3" = 0.7; }; 
                }
                { "type" = "builtin"; "name" = "lpf"; "label" = "bq_lowpass";
                  "control" = { "Freq" = 120.0; }; }

                { "type" = "builtin"; "name" = "m_tre"; "label" = "mixer";
                  # Scaled by 0.7 to prevent clipping in summed high-pass path
                  "control" = { "Gain 1" = 0.56; "Gain 2" = 0.56; "Gain 3" = 0.7; }; 
                }
                { "type" = "builtin"; "name" = "hpf"; "label" = "bq_highpass";
                  "control" = { "Freq" = 1200.0; }; }

                { "type" = "builtin"; "name" = "m_fin"; "label" = "mixer";
                  # Scaled by 0.7 to prevent clipping in final mix (1.0+0.7+0.2+0.2+0.3 = 2.4 peak -> safe at 1.68)
                  "control" = { "Gain 1" = 0.7; "Gain 2" = 0.49; "Gain 3" = 0.14; "Gain 4" = 0.14; "Gain 5" = 0.21; }; 
                }
              ];

              "links" = [
                { "output" = "cFL:Out"; "input" = "m_lpf:In 1"; }
                { "output" = "cFR:Out"; "input" = "m_lpf:In 2"; }
                { "output" = "cFC:Out"; "input" = "m_lpf:In 3"; }

                { "output" = "cFL:Out"; "input" = "m_tre:In 1"; }
                { "output" = "cFR:Out"; "input" = "m_tre:In 2"; }
                { "output" = "cFC:Out"; "input" = "m_tre:In 3"; }

                { "output" = "m_lpf:Out"; "input" = "lpf:In"; }
                { "output" = "m_tre:Out"; "input" = "hpf:In"; }

                { "output" = "lpf:Out"; "input" = "m_fin:In 1"; }
                { "output" = "hpf:Out"; "input" = "m_fin:In 2"; }
              ];

              "inputs"  = [ "cFL:In" "cFR:In" "cFC:In" "m_fin:In 3" "m_fin:In 4" "m_fin:In 5" ];
              "outputs" = [ "m_fin:Out" ];
            };

            "capture.props" = {
              "target.object" = "virtual_5_1_expanded";
              "stream.capture.sink" = true;
              "node.autoconnect" = true;

              "audio.channels" = 6;
              "audio.position" = [ "FL" "FR" "FC" "LFE" "RL" "RR" ];
              "stream.dont_remix" = true;
            };

            "playback.props" = {
              "target.object" = "bluez_output.D8_AA_59_C9_38_96.1";
              "node.autoconnect" = true;

              "audio.channels" = 1;
              "audio.position" = [ "MONO" ];
              "stream.dont_remix" = true;
            };
          };
        }
      ];
    };
  };
}