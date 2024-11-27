{
  lib,
  config,
  shaderbg,
  ...
}: let
  wp_manager = config.desktops.wallpaper;
  cfgCheck = name: name == wp_manager;
in {
  imports = [
    (lib.mkIf
      (cfgCheck "shaderbg")
      shaderbg.homeManagerModules.default)
  ];
}
