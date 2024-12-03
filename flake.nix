{
  inputs = {
    # Essentials
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Window Manager Flakes
    niri.url = "github:sodiboo/niri-flake";

    # Wallpaper Flakes
    swww.url = "github:LGFae/swww";
    shaderbg.url = "/home/xvrqt/Development/shaderbg-flake";

    # Application Launcher Flakes
  };

  outputs = {
    niri,
    nixpkgs,
    shaderbg,
    flake-utils,
    ...
  }: let
    machines = ["nyaa" "spark"];
    nixosModulesWrapped = flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system overlays;};
        overlays = [niri.overlays.niri];
      in {
        # You need this regardless if you use the Home Manager Module
        nixosModules = {
          default = {pkgs, ...}: {
            imports = [
              ###################
              # Window Managers #
              ###################
              # NIRI #
              niri.nixosModules.niri
              (import ./window-managers/niri/nixosModule.nix {
                inherit pkgs niri;
              })
              ##############
              # Wallpapers #
              ##############
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
        lib = pkgs.lib;
        pkgs = import nixpkgs {inherit system;};
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
                ##############
                # Wallpapers #
                ##############
                # SHADERBG #
                # Import the wallpaper manager NixOS Modules
                (lib.MkIf
                  (config.desktops.wallpaper == "shaderbg")
                  shaderbg.homeManagerModules.default)
                # (import ./wallpaper/homeManagerModule.nix {inherit pkgs lib config shaderbg;})
                ###################
                # Window Managers #
                ###################
                # Niri #
                # # Include our Home Manager Module which enables and configures Niri
                (lib.mkIf (config.desktops.window-manager == "niri") import ./window-managers/niri/homeManagerModule {inherit lib niri shaderbg config machine;})
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
