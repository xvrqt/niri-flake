{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
  # Niri is strict about checking the attrsets passed to parameters
  # We must filter out the "output" field of the attrset to use it in the config
  outputToNiriSubModule = output: (lib.attrsets.filterAttrs (n: _: n != "output") output);
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings.outputs =
      builtins.listToAttrs
      (builtins.map (output: {
          name = output.output;
          value = outputToNiriSubModule output;
        })
        config.desktops.outputs);
  };
}
