{
  lib,
  config,
  ...
}: let
  cfg = config.desktops.launcher;
  cfgCheck = cfg.enable && cfg.flavor == "fuzzel";
  terminal = config.terminal.emulator or "kitty";
in {
  config = lib.mkIf cfgCheck {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          # TODO: Make this follow terminal -> emulator
          terminal = "${terminal}";
        };
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
}
