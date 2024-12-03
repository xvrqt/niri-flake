{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
in {
  programs.niri.settings = lib.mkIf cfgCheck {
    # Use the default animations
    animations = {};
  };
}
