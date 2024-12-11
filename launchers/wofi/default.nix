{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.launcher == "wofi";
  theme =
    if config.desktops.launcher.theme == null
    then "default.css"
    else (config.desktops.launcher.theme + ".css");
in {
  config = lib.mkIf cfgCheck {
    programs.wofi.settings = {
      enable = true;
      settings = {};
      style = builtins.readFile (./themes + "/${theme}");
    };
  };
}
