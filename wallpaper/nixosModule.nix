{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  wp_manager = config.desktops.wallpaper;
  cfgCheck = name: name == wp_manager;
in {
  imports = [
    (lib.mkIf
      (cfgCheck "shaderbg")
      inputs.shaderbg.nixosModule.${pkgs.system}.default)
  ];
}
