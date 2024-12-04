{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings = {
      spawn-at-startup = [
        {command = ["waypaper" "--restore"];}
      ];
    };
  };
}
