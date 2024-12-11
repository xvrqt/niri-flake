{lib, ...}: {
  options = {
    desktops = {
      # Select a Wallpaper Manager
      wallpaper = lib.mkOption {
        type = lib.types.enum ["swww" "shaderbg"];
        default = "shaderbg";
      };
    };
  };
}
