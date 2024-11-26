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
    # monitors = import ./monitors.nix;
    monitors = {
      # Large Curved Monitor
      odyssey = {
        # Probably wrong
        output = "HDMI-5";
        mode = {
          width = 7680;
          height = 2160;
          refresh = 119.997;
        };
        variable-refresh-rate = true;
        scale = 1.0;
        position = {
          x = 5120;
          y = 0;
        };
        transform = {
          flipped = false;
          rotation = 0;
        };
      };

      # Mac Book Pro Screen
      mac-book-pro = {
        mode = {
          width = 3024;
          height = 1890;
          refresh = 60.0;
        };
        variable-refresh-rate = false;
        scale = 2.0;
        position = {
          x = 0;
          y = 0;
        };
        transform = {
          flipped = false;
          rotation = 0;
        };
        output = "eDP-1";
      };
    };
    # You need this regardless if you use the Home Manager Module
    nixosModules = {
      default = {pkgs, ...}: {
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
            # Include our Home Manager Module which enables and configures Niri
            (import ./homeManagerModule {inherit lib niri pkgs shaderbg swww config machine;})
          ];
        };
      })
      machines);
  };
}
