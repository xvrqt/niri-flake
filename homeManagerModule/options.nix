{lib, ...}: let
  # Helper function (sets priority lower than mkOptionEnable)
  mkEnabled = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in {
  options = {
    desktops = {
      # Where to save screenshots
      screenshot-path = lib.mkOption {
        type = lib.types.path;
        default = ./. + "~/Pictures/Screenshots/scrot_%Y-%m-%d-%H-%M-%S.png";
      };

      # Window Managers
      niri = {
        enable = mkEnabled;
        monitor = lib.mkOption {
          type = lib.types.enum ["odyssey" "mac-book-pro"];
          default = null;
        };

        animations = {
          window-close.enable = mkEnabled;
        };
      };
    };
  };
}
