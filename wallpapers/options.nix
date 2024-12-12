{lib, ...}: let
  mkEnabled = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
in {
  options = {
    desktops = {
      # Select a Wallpaper Manager
      wallpaper = {
        # Enable custom handling of wallpapers
        enable = mkEnabled;
        # Which type of wallpaper should be used
        flavor = lib.mkOption {
          type = lib.types.enum ["swww" "shaderbg"];
          default = "shaderbg";
        };

        # Packages for proper function across flakes
        package = lib.mkOption {
          type = lib.types.package;
          description = "Main wallpaper program.\ne.g. 'shaderbg'";
        };
        init = lib.mkOption {
          type = lib.types.package;
          description = "Script that initializes the wallpaper.";
        };
        change = lib.mkOption {
          type = lib.types.package;
          description = "Script that changes the current the wallpaper image/shader.";
        };
        toggle = lib.mkOption {
          type = lib.types.package;
          description = "Script that toggles between wallpaper on/off states.";
        };
        exit = lib.mkOption {
          type = lib.types.package;
          description = "Script that quits the wallpaper program.";
        };
      };
    };
  };
}
