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
  programs.niri.settings.layout = lib.mkIf cfgCheck {
    default-column-width = {proportion = 1.0 / 2.0;};
  };
}
