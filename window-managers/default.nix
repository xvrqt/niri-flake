{
  config,
  machine,
  lib,
  ...
}: {
  imports = [
    ./options.nix
    (import ./niri {inherit lib config machine;})
  ];
}
