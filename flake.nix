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
        pkgs = import nixpkgs {inherit system overlays;};
        overlays = [niri.overlays.niri];
      in {
        # You need this regardless if you use the Home Manager Module
        nixosModules = {
          default = {
            imports = [
              # Re-import the original NixOS module from the Niri Flake
              niri.nixosModules.niri
              # Import the wallpaper manager NixOS Modules
              ./wallpaper/nixosModule.nix
              #shaderbg.nixosModules.${system}.default
              # Include our NixOS Module which enables and configures Niri
              (import ./nixosModule.nix {
                inherit pkgs niri swww;
              })
            ];
          };
        };
      }
    );
  in {
    # My personal monitor collection; as the layout of this is tightly bound, it's nice to have it on hand
    monitors = import ./monitors.nix;

    # NixOS Modules Per System
    nixosModules = nixosModulesWrapped.nixosModules;

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
            # Import the options that help define the desktop experience
            ./options.nix
            # Add in the ancillary packages
            # {
            #   home.packages = lib.mkIf (config.desktops.wallpaper
            #     == "shaderbg") [
            #     shaderbg.inputs.shaderbg.packages.${pkgs.system}.default
            #     shaderbg.packages.${pkgs.system}.initWallpaper
            #     shaderbg.packages.${pkgs.system}.changeWallpaper
            #     shaderbg.packages.${pkgs.system}.exitWallpaper
            #   ];
            # }
            # Include our Home Manager Module which enables and configures Niri
            (import ./homeManagerModule {inherit lib niri pkgs shaderbg swww config machine;})
          ];
        };
      })
      machines);
  };
}
