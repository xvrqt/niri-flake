{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
  outputToNiriSubModule = output: (lib.attrsets.filterAttrs (n: _: n != "output") output);
in {
  #programs.niri.settings.outputs."${OUTPUT_NAME}" = SUBMODULE;
  programs.niri.settings.outputs =
    lib.mkIf cfgCheck # Only make if Niri is enabled
    
    (builtins.listToAttrs
      (builtins.map (output: {
          name = output.output;
          value = outputToNiriSubModule output;
        })
        config.desktops.outputs));
}
