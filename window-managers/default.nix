{
  lib,
  pkgs,
  niri,
  config,
  machine,
  shaderbg,
  ...
}: {
  nixosModules = [
    (import ./niri/nixosModule.nix)
  ];
  homeManagerModules = [
    (import ./niri/homeManagerModule {inherit lib niri config machine shaderbg;})
  ];
}
