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
    programs.niri.settings.input = {
      # Add touchpad configuration for the laptop
      touchpad = {
        # Tap-to-click
        tap = true;
        # Disable while typing
        dwt = true;
        left-handed = true;
        scroll-method = "two-finger";
      };
    };
  };
}
