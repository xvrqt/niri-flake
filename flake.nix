{
  inputs = {
    niri.url = "github:sodiboo/niri-flake";
    #niri.url = "github:xvrqt/niri-flake";
  };

  outputs = {niri, ...}: {
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

    homeManagerModules = {
      default = {
        lib,
        pkgs,
        config,
        ...
      }: {
        imports = [
          # Re-import the original Home Manager Module from the Niri Flake
          niri.homeModules.niri
          # Include our Home Manager Module which enables and configures Niri
          (import ./homeManagerModule {
            inherit lib;
            inherit niri;
            inherit pkgs;
            inherit config;
          })
        ];
      };
    };
  };
}
