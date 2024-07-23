{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.niri.enable;
in {
  programs.niri.settings = lib.mkIf cfgCheck {
    debug = {
      wait-for-frame-completion-before-queueing = [];
    };
  };
}
