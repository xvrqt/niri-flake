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

  # Mac Book Pro Screen 
  mac-book-pro = setDef {
    mode = {
      width = 3024;
      height = 1890;
      refresh = 60.0;
    };
    variable-refresh-rate = false;
    scale = 2.0;
    position = {
      x = 0;
      y = 0;
    };
    transform = {
      flipped = false;
      rotation = 0;
    };
  };
in {
  programs.niri.settings.outputs."eDP-1" = lib.mkIf (cfgCheck "mac-book-pro") mac-book-pro;
  programs.niri.settings.outputs."HDMI-A-5" = lib.mkIf (cfgCheck "odyssey") odyssey;
}
