{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
  monitors = import ./monitors.nix;
in {
  programs.niri.settings.outputs."HDMI-A-5" = lib.mkIf cfgCheck monitors.odyssey;
}
