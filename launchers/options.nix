{lib, ...}: {
  options = {
    desktops = {
      # Select a Wallpaper Manager
      launcher = lib.mkOption {
        type = lib.types.enum ["wofi" "fuzzel"];
        default = "fuzzel";
      };
    };
  };
}
