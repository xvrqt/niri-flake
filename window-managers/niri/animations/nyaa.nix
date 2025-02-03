{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
  window_close = ./shaders/window_close.frag;
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings = {
      animations = {
        #   window-close.easing = lib.mkIf config.desktops.niri.animations.window-close.enable {
        #     duration-ms = 2000;
        #     curve = "linear";
        #   };
        #
        #   shaders.window-close = lib.mkIf config.desktops.niri.animations.window-close.enable (builtins.toString window_close);
      };
    };
  };
}
