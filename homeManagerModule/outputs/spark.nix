{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
  #  monitors = import ./monitors.nix;
  # Get the output name; e.g. "eDP-1"
  OUTPUT = builtins.head config.desktops.outputs;
  SUBMODULE = builtins.filterAttr (n: v: n != "output") OUTPUT;
  OUTPUT_NAME = OUTPUT.output;
in {
  #programs.niri.settings.outputs.${OUTPUT} = lib.mkIf cfgCheck monitors.mac-book-pro;
  programs.niri.settings.outputs."${OUTPUT_NAME}" = SUBMODULE;
}
