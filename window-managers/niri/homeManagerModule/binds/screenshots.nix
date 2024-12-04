{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings = {
      binds = with config.lib.niri.actions; {
        # Screenshots
        "Alt+Shift+1".action = screenshot;
        "Alt+Shift+2".action = screenshot-window;
        "Alt+Shift+3".action = screenshot-screen;
      };
    };
  };
}
