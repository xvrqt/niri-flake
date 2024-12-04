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
          default = {
            lib,
            pkgs,
            config,
            ...
          }: {
            imports = [
              # Annoyingly, Niri requires a NixOS Module to work
              niri.nixosModules.niri
              # ./window-managers/nixosModules/default.nix
            ];
            config = lib.mkIf config.programs.niri.enable {
              nixpkgs.overlays = [niri.overlays.niri];
              programs.niri.package = pkgs.niri-stable;
              # Enable Wayland support in Electron based applications (gross!)
              environment.variables.NIXOS_OZONE_WL = "1";
            };
          };
        };
      }
    );

    homeManagerModulesWrapped = flake-utils.lib.eachDefaultSystem (
      system: let
      in {
        homeManagerModules = builtins.listToAttrs (builtins.map (machine: {
            name = machine;
            value = {...}: {
              imports = [
                # Import the options that help define the desktop experience
                ./options.nix
                ##############
                # Wallpapers #
                ##############
                # SHADERBG #
                # Import the wallpaper manager NixOS Modules
                shaderbg.homeManagerModules.default
                # (import ./wallpaper/homeManagerModule.nix {inherit pkgs lib config shaderbg;})
                ###################
                # Window Managers #
                ###################
                # Niri #
                ./window-managers/homeManagerModules
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
