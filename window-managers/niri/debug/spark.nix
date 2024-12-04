{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings = {
      debug = {
        render-drm-device = "/dev/dri/renderD128";
      };
    };
  };
}
