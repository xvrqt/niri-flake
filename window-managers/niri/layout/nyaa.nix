{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
in {
  imports = [
    ./common.nix
  ];
  config = lib.mkIf cfgCheck {
    programs.niri.settings.layout = {
      default-column-width = {proportion = 1.0 / 4.0;};
    };
  };
}
