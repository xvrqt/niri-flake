{
  inputs = {
    niri.url = "github:sodiboo/niri-flake";
    swww.url = "github:LGFae/swww";
    shaderbg.url = "/home/xvrqt/Development/shaderbg-flake";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    niri,
    swww,
    nixpkgs,
    shaderbg,
    flake-utils,
    ...
  }: let
    machines = ["nyaa" "spark"];
    nixosModulesWrapped = flake-utils.lib.eachDefaultSystem (
      system: let
        lib = pkgs.lib;
        pkgs = import nixpkgs {inherit system overlays;};
        overlays = [niri.overlays.niri];
      in {
        # You need this regardless if you use the Home Manager Module
        nixosModules = {
          default = {config, ...}: {
            imports = [
              # Re-import the original NixOS module from the Niri Flake
              niri.nixosModules.niri
              # Include our NixOS Module which enables and configures Niri
              (import ./nixosModule.nix {
                inherit pkgs niri swww;
              })
            ];
          };
        };
      }
    );

    # Home Manager Module is required to declaratively configure Niri
    # (using the Sodiboo Flake, that is)
    # We pass in the machine name to retrieve the correct configuration
    homeManagerModulesWrapped = flake-utils.lib.eachDefaultSystem (
      system: let
        # lib = pkgs.lib;
        # pkgs = import nixpkgs {inherit system;};
      in {
        homeManagerModules = builtins.listToAttrs (builtins.map (machine: {
            name = machine;
            value = {
              lib,
              pkgs,
              config,
              ...
            }: {
              imports = [
                # Import the options that help define the desktop experience
                ./options.nix
                # Import the wallpaper manager NixOS Modules
                shaderbg.homeManagerModules.default
                # (import ./wallpaper/homeManagerModule.nix {inherit pkgs lib config shaderbg;})
                # # Include our Home Manager Module which enables and configures Niri
                (import ./homeManagerModule {inherit lib niri shaderbg swww config machine;})
              ];
            };
          })
          machines);
      }
    );
  in {
    # My personal monitor collection; as the layout of this is tightly bound, it's nice to have it on hand
    monitors = import ./monitors.nix;
    nixosModules = nixosModulesWrapped.nixosModules;
    homeManagerModules = homeManagerModulesWrapped.homeManagerModules;
  };
}
