# Niri Flake
This flake installs and configures the Niri tiling window manager. It leeches off of [Sodiboo's Flake](https://github.com/sodiboo/niri-flake), and of course, the wonderful [Niri tiling window manager](https://github.com/YaLTeR/niri).

It adds some new options for people using home-manager.

# Usage
This flake can be used as either a NixOS Module or a Home-Manager Module (or both). Simply add the flake to your inputs, and add the default module to the your NixOS/Home Configuration.
**This will enable and configure everything by default.** Continue reading to learn how to customize your configuration.

## NixOS Installation
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Add the Niri flake :]
    niri.url = "github:xvrqt/niri-flake";
  };
  
  outputs = { nixpkgs, niri, ... }: let
    mkSystem = nixpkgs.lib.nixosSystem;
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    nixosConfigurations.myComputer =  mkSystem {
      inherit pkgs;
        modules = [
          niri.nixosModules.default # <--- This is the important bit
          configuraiton.nix
       ];
    };
  };
}
```

## Home-Manager Installation
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add the Niri flake :]
    niri.url = "github:xvrqt/niri-flake";
  };
  
  outputs = { nixpkgs, home-manager, niri, ... }: let
    mkHome = home-manager.lib.homeManagerConfiguration;
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    homeConfiguration = mkHome {
      inherit pkgs;
        modules = [
        niri.homemanagerModules.default # <-- This is the important bit
        home.nix
       ];
    };
  };
}
```
## Customization
If you use home-manager, you can customize the Niri installation further. You can also create a completely custom Niri configuration the usual way: `programs.niri.settings = {}`
```nix
  # This works on Home-Manager Modules only
  desktops = {
    screenshot-path = ./my-saved-screenshots.png;

    niri = {
      enable = true;
      monitor = "odyssey"; # Add your own monitors to `outputs.nix` and `options.nix`
      animations = {
        window-close.enable = true;
      };
    };
  };

```

-----
![Woman works on a computer](https://github.com/xvrqt/cli-flake/blob/dev/patron.png?raw=true "Patron Saint")
P.S. I Love You
