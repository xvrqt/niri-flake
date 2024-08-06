{
  pkgs,
  niri,
  swww,
  ...
}: {
  # Overlay Niri so that anything else that uses it as a dependency will use the correct version
  nixpkgs.overlays = [niri.overlays.niri];

  # Enable Niri
  programs.niri = {
    enable = true;
    # Otherwise there is the potential to get out of sync with Niri in NixPkgs
    package = pkgs.niri-stable;
  };

  # Enable Wayland support in Election based applications (gross!)
  environment.variables.NIXOS_OZONE_WL = "1";

  # Useful packages to include with a Desktop Environment
  environment.systemPackages = [
    swww.packages.${pkgs.system}.swww
    pkgs.waypaper

    pkgs.cage
    pkgs.gamescope
    pkgs.libsecret
    pkgs.wl-clipboard
    pkgs.wayland-utils
  ];
}
