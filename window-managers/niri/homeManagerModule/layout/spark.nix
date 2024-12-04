{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
in {
  imports = [
    ./common.nix
  ];
  config = lib.mkIf cfgCheck {
    programs.niri.settings.layout = {
      default-column-width = {proportion = 1.0 / 2.0;};
    };
  };
}
