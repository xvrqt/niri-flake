{
  inputs = {
    niri.url = "github:sodiboo/niri-flake";
    swww.url = "github:LGFae/swww";
    shaderbg.url = "/home/xvrqt/Development/shaderbg-flake";
  };

  outputs = {
    niri,
    swww,
    shaderbg,
    ...
  }: let
    machines = ["nyaa" "spark"];
  in {
    # My personal monitor collection; as the layout of this is tightly bound, it's nice to have it on hand
    monitors = import ./monitors.nix;
    # You need this regardless if you use the Home Manager Module
    nixosModules = {
      default = {
        lib,
        pkgs,
        config,
        ...
      }: {
        imports = [
          # Re-import the original NixOS module from the Niri Flake
          niri.nixosModules.niri
          # Import the wallpaper manager NixOS Modules
          # shaderbg.nixosModules.${pkgs.systems}.default
          # Include our NixOS Module which enables and configures Niri
          (import ./nixosModule.nix {
            inherit pkgs niri swww;
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
            # Import the options that help define the desktop experience
            ./options.nix
            # Add in the ancillary packages
            {
              home.packages = lib.mkIf (config.desktops.wallpaper
                == "shaderbg") [
                shaderbg.inputs.shaderbg.packages.${pkgs.system}.default
                shaderbg.packages.${pkgs.system}.initWallpaper
                shaderbg.packages.${pkgs.system}.changeWallpaper
                shaderbg.packages.${pkgs.system}.exitWallpaper
              ];
            }
            # Include our Home Manager Module which enables and configures Niri
            (import ./homeManagerModule {inherit lib niri pkgs shaderbg swww config machine;})
          ];
        };
      })
      machines);
  };
}
