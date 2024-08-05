{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
in {
  programs.niri.settings = lib.mkIf cfgCheck {
    binds = with config.lib.niri.actions; {
      # Screenshots
      "Alt+Shift+1".action = screenshot;
      "Alt+Shift+2".action = screenshot-window;
      "Alt+Shift+3".action = screenshot-screen;
    };
  };
}
