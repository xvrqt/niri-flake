{
  lib,
  config,
  ...
}: let
  # Use the default terminal
  terminal = config.terminal.emulator or "kitty";
  cfgCheck = config.desktops.niri.enable;
in {
  programs.niri.settings = lib.mkIf cfgCheck {
    binds = with config.lib.niri.actions; let
      sh = spawn "sh" "-c";
    in {
      # Shortcuts
      # Open a Terminal
      "Mod+T".action = spawn terminal;
      "Mod+W".action = spawn "librewolf";
      # Open Rofi Application Launcher
      "Mod+Return".action = sh "rofi -show drun";
      # Show Hotkey Cheat Sheet
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      # Power Off Monitors
      "Mod+Shift+P".action = power-off-monitors;
      "Mod+E".action = quit {skip-confirmation = true;};
    };
  };
}
