{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
  monitors = import ./monitors.nix;
  # Get the output name; e.g. "eDP-1"
  OUTPUT = builtins.head config.desktops.outputs;
in {
  #programs.niri.settings.outputs.${OUTPUT} = lib.mkIf cfgCheck monitors.mac-book-pro;
  programs.niri.settings.outputs.${OUTPUT.output} = {};
}
