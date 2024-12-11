{
  lib,
  pkgs,
  config,
  ...
}: let
  cfgCheck = config.desktops.launcher == "fuzzel";
in {
  config = lib.mkIf cfgCheck {
    programs.wofi.settings = {
      enable = true;
      settings = {
        main = {
          # TODO: Make this follow terminal -> emulator
          terminal = "${pkgs.foot}/bin/foot";
          colors = {
            background = "1E1E2EDD";
            text = "CDD6F4FF";
            prompt = "BAC2DEFF";
            input = "CDD6F4FF";
            match = "F5E0DCFF";
            selection = "585B70FF";
            selection-text = "CDD6F4FF";
            selection-match = "F5E0DCFF";
            counter = "7F849CFF";
            border = "F5E0DCFF";
          };
        };
      };
    };
  };
}
