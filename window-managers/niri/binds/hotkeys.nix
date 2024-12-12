{
  lib,
  config,
  ...
}: let
  # Use the default terminal
  cfg = config.desktops;
  cfgCheck = cfg.window-manager == "niri";
  launcher = cfg.launcher.flavor;
  terminal = config.terminal.emulator or "kitty";
  wallpaperToggle = "${cfg.wallpaper.toggle}/bin/toggleWallpaper";
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings = {
      binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
      in {
        # Shortcuts
        # Open a Terminal
        "Mod+T".action = spawn terminal;
        "Mod+W".action = spawn "librewolf";
        "Mod+B".action = spawn wallpaperToggle;
        # Open Rofi Application Launcher
        "Mod+Return".action = spawn launcher;
        # Show Hotkey Cheat Sheet
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        # Power Off Monitors
        "Mod+Shift+P".action = power-off-monitors;
        "Mod+Shift+Q".action = quit {skip-confirmation = false;};
      };
    };
  };
}
