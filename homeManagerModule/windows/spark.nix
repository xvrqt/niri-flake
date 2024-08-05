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
}
