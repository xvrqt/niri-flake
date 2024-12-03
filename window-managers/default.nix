{
  pkgs,
  config,
  machine,
  ...
}: {
  nixosModules = [
    (import ./niri/nixosModule.nix)
  ];
}
