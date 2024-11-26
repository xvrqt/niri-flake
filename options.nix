{lib, ...}: let
  # Helper function (sets priority lower than mkOptionEnable)
  mkEnabled = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
  monitors = import ./monitors.nix;
in {
  options = {
    desktops = {
      # Where to save screenshots
      screenshot-path = lib.mkOption {
        type = lib.types.path;
        default = ./. + "~/Pictures/Screenshots/scrot_%Y-%m-%d-%H-%M-%S.png";
      };

      # Select a Window Manager
      window-manager = lib.mkOption {
        type = lib.types.enum ["niri"];
        default = "niri";
      };

      # Select a Wallpaper Manager
      wallpaper = lib.mkOption {
        type = lib.types.enum ["swww" "shaderbg"];
        default = "shaderbg";
      };

      # Set Output(s)
      outputs = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = [monitors.mac-book-pro];
      };

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
