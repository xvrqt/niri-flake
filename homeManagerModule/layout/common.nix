{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
in {
  programs.niri.settings = lib.mkIf cfgCheck {
    layout = {
      gaps = 16;
      preset-column-widths = [
        {proportion = 1.0 / 6.0;}
        {proportion = 1.0 / 4.0;}
        {proportion = 1.0 / 3.0;}
        {proportion = 1.0 / 2.0;}
        {proportion = 2.0 / 3.0;}
        {proportion = 3.0 / 4.0;}
        {proportion = 5.0 / 6.0;}
      ];

      focus-ring.enable = false;
      border = {
        enable = true;
        width = 4;
        active.gradient = {
          from = "#EF7627";
          to = "#D162A4";
          angle = 45;
          in' = "oklch longer hue";
        };
        inactive.gradient = {
          from = "#B55690";
          to = "#D52D00";
          angle = 45;
        };
      };
    };
  };
}
