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
  programs.niri.settings = lib.mkIf cfgCheck {
    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in {};
  };
}
