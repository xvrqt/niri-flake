{
  lib,
  pkgs,
  config,
  ...
}: {
  config = lib.mkIf (config.desktop.window-manager == "niri") {
    # Enable Niri
    programs.niri = {
      enable = true;
      # Otherwise there is the potential to get out of sync with Niri in NixPkgs
      package = pkgs.niri-stable;
    };

    # Enable Wayland support in Electron based applications (gross!)
    environment.variables.NIXOS_OZONE_WL = "1";

    # Useful packages to include with a Desktop Environment
    environment.systemPackages = [
      pkgs.waypaper

      pkgs.cage
      pkgs.gamescope
      pkgs.libsecret
      pkgs.wl-clipboard
      pkgs.wayland-utils
    ];
  };
}
