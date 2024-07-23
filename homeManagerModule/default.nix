{config, ...}: {
  imports = [
    #  Defines options for home-manager users
    ./options.nix
    # Keybindings and Shortcuts
    ./binds.nix
    # How to handle keyboard, mouse, and trackpad events
    ./inputs.nix
    # Monitors and their configurations
    ./outputs.nix
    # How to decorate and display the windows
    ./layout.nix
    # Window Rules
    ./windows.nix
    # Custom window animations and shaders
    ./animations.nix
    # Debug flags, experimental settings
    ./debug.nix
  ];

  config = {
    programs.niri = {
      enable = config.desktops.niri.enable;

      settings = {
        # No client-side decorations
        prefer-no-csd = true;
        # Where to save screenshots
        screenshot-path = builtins.toString config.desktops.screenshot-path;
        # We don't need to be shown the hotkey cheat-sheet at startup
        hotkey-overlay.skip-at-startup = true;
      };
    };
  };
}
