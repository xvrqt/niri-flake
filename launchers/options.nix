{lib, ...}: let
  mkEnabled = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in {
  options = {
    desktops = {
      launcher = {
        # Enable custom handling of wallpapers
        enable = mkEnabled;
        # Which type of wallpaper should be used
        flavor = lib.mkOption {
          type = lib.types.enum ["fuzzel"];
          default = "fuzzel";
        };

        # Packages for proper function across flakes
        package = lib.mkOption {
          type = lib.types.package;
          description = "Main application launcher program.\ne.g. 'rofi'";
        };
      };
    };
  };
}
