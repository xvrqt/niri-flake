{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
  monitors = import ./monitors.nix;
in {
  programs.niri.settings.outputs."eDP-1" = lib.mkIf cfgCheck monitors.mac-book-pro;
}
