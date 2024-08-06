{
  config,
  machine,
  ...
}: {
  # Imports settings based on the machine it is running on
  imports = [
    #  Defines options for home-manager users
    ./options.nix
    # Programs to launch at startup
    ./startup/${machine}.nix
    # Keybindings and Shortcuts
    ./binds/${machine}.nix
    # How to handle keyboard, mouse, and trackpad events
    ./inputs/${machine}.nix
    # Monitors and their configurations
    ./outputs/${machine}.nix
    # How to decorate and display the windows
    ./layout/${machine}.nix
    # Window Rules
    ./windows/${machine}.nix
    # Custom window animations and shaders
    ./animations/${machine}.nix
    # Debug flags, experimental settings
    ./debug/${machine}.nix
  ];

  config = {
    # Configure Niri (machine agnostic);
    programs.niri = {
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
