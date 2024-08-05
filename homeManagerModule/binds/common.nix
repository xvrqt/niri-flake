{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
in {
  imports = [
  	./windows.nix
	./audio_controls.nix
	./hotkeys.nix
	./screenshots.nix
  ];
  programs.niri.settings = lib.mkIf cfgCheck {
    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in {};
  };
}
