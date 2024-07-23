{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
  window_close = ./shaders/window_close.frag;
in {
  programs.niri.settings = lib.mkIf cfgCheck {
    animations = {
      window-close.easing = lib.mkIf config.desktops.niri.animations.window-close.enable {
        duration-ms = 2000;
        curve = "linear";
      };

      shaders.window-close = lib.mkIf config.desktops.niri.animations.window-close.enable (builtins.toString window_close);
    };
  };
}
