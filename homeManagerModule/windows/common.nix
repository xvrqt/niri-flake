{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
in {
  programs.niri.settings = lib.mkIf cfgCheck {
    window-rules = [
      # All windows share the same border rounding
      {
        geometry-corner-radius = let
          r = 4.0;
        in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;
      }
      # Make non-active windows semi-transparent
      {
        matches = [{is-active = false;}];
        opacity = 0.9;
      }
      # If the browser is showing a YouTube video, don't make it semi-transparent
      {
        matches = [
          {title = "^.*[Y|y]ou[T|t]ube.*$";}
          {app-id = "LibreWolf";}
        ];
        opacity = 1.0;
      }
    ];
  };
}
