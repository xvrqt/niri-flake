{
  lib,
  config,
  ...
}: let
  setDef = lib.mkOverride 1000;
  cfgCheck = monitor: (config.desktops.niri.enable && (config.desktops.niri.monitor == monitor));

  # Large Curved Monitor
  odyssey = setDef {
    mode = {
      width = 7680;
      height = 2160;
      refresh = 119.997;
    };
    variable-refresh-rate = true;
    scale = 1.0;
    position = {
      x = 5120;
      y = 0;
    };
    transform = {
      flipped = false;
      rotation = 0;
    };
  };
in {
  programs.niri.settings.outputs."HDMI-A-5" = lib.mkIf (cfgCheck "odyssey") odyssey;
}
