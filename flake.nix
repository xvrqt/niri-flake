{
  inputs = {
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = {niri, ...}: let
    machines = ["nyaa" "spark"];
  in {
    nixosModules = {
      default = {pkgs, ...}: {
        imports = [
          # Re-import the original NixOS module from the Niri Flake
          niri.nixosModules.niri
          # Include our NixOS Module which enables and configures Niri
          (import ./nixosModule.nix {
            inherit pkgs;
            inherit niri;
          })
        ];
      };
    };

    # Home Manager Module is required to declaratively configure Niri
    # (using the Sodiboo Flake, that is)
    # We pass in the machine name to retrieve the correct configuration
    homeManagerModules = builtins.listToAttrs (builtins.map (machine: {
        name = machine;
        value = {
          lib,
          pkgs,
          config,
          ...
        }: {
          imports = [
            # Re-import the original Home Manager Module from the Niri Flake
            niri.homeModules.niri
            # Include our Home Manager Module which enables and configures Niri
            (import ./homeManagerModule {inherit lib niri pkgs config machine;})
          ];
        };
      })
      machines);
  };
}
