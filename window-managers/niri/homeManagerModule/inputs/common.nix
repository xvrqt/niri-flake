{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings = {
      input = {
        # Flags
        warp-mouse-to-focus = true;
        focus-follows-mouse = {
          enable = true;
          # Won't build despite conforming to the docs :s
          #	max-scroll-amount = "0%";
        };

        # If you jump to the workspace you're currently viewing, it will take you to previous workspace
        workspace-auto-back-and-forth = true;

        keyboard = {
          xkb = {
            layout = "us";
            # Remap Caps-Lock to ESC
            options = "caps:escape";
          };
        };

        mouse = {
          accel-speed = 0.2;
          accel-profile = "flat";
          scroll-method = "no-scroll";
        };
      };
    };
  };
}
