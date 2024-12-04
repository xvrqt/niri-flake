{lib, ...}: {
  options = {
    desktops = {
      # Select a Window Manager
      window-manager = lib.mkOption {
        type = lib.types.enum ["niri"];
        default = "niri";
      };
    };
  };
}
