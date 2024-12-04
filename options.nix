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
      # Set Output(s)
      outputs = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = [monitors.mac-book-pro];
      };

      # Select a Wallpaper Manager
      wallpaper = lib.mkOption {
        type = lib.types.enum ["swww" "shaderbg"];
        default = "shaderbg";
      };

      # Where to save screenshots
      screenshot-path = lib.mkOption {
        type = lib.types.path;
        default = ./. + "~/Pictures/Screenshots/scrot_%Y-%m-%d-%H-%M-%S.png";
      };
    };
  };
}
