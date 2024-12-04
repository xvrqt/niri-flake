{
  lib,
  pkgs,
  niri,
  config,
  ...
}: {
  config = lib.mkIf config.programs.niri.enable {
    nixpkgs.overlays = [niri.overlays.niri];
    programs.niri.package = pkgs.niri-stable;
    # Enable Wayland support in Electron based applications (gross!)
    environment.variables.NIXOS_OZONE_WL = "1";
  };

  # Useful packages to include with a Desktop Environment
  # environment.systemPackages = [
  #   pkgs.waypaper
  #
  #   pkgs.cage
  #   pkgs.gamescope
  #   pkgs.libsecret
  #   pkgs.wl-clipboard
  #   pkgs.wayland-utils
  # ];
}
