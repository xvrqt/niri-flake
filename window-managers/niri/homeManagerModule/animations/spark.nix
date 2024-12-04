{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings = {
      # Use the default animations
      animations = {};
    };
  };
}
