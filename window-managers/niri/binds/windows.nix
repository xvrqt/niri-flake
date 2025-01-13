{
  lib,
  config,
  ...
}: let
  cfgCheck = config.desktops.window-manager == "niri";
in {
  config = lib.mkIf cfgCheck {
    programs.niri.settings = {
      binds = with config.lib.niri.actions; {
        # Window Controls
        "Mod+Q".action.close-window = [];

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Window Focus
        "Mod+H".action = focus-column-or-monitor-left;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+L".action = focus-column-or-monitor-right;
        "Mod+Shift+H".action = focus-column-first;
        "Mod+Shift+L".action = focus-column-last;

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        # "Mod+Shift+1".action.focus-monitor = 1;
        # "Mod+Shift+2".action.focus-monitor = 2;
        # "Mod+Shift+3".action.focus-monitor = 3;
        # "Mod+Shift+4".action.focus-monitor = 4;
        # "Mod+Shift+5".action.focus-monitor = 5;
        # "Mod+Shift+6".action.focus-monitor = 6;
        # "Mod+Shift+7".action.focus-monitor = 7;
        # "Mod+Shift+8".action.focus-monitor = 8;
        # "Mod+Shift+9".action.focus-monitor = 9;

        # Window Movement ;::; intra-workspace
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+L".action = move-column-right;

        # Window Movement ;::; inter-monitor
        "Mod+Ctrl+Shift+H".action = move-column-left-or-to-monitor-left;
        # "Mod+Ctrl+Shift+J".action = move-window-down-or-to-monitor-down;
        # "Mod+Ctrl+Shift+K".action = move-window-up-or-to-monitor-up;
        "Mod+Ctrl+Shift+L".action = move-column-right-or-to-monitor-right;

        # "Mod+Ctrl+Shift+1".action.move-column-to-monitor = 1;
        # "Mod+Ctrl+Shift+2".action.move-column-to-monitor = 2;
        # "Mod+Ctrl+Shift+3".action.move-column-to-monitor = 3;
        # "Mod+Ctrl+Shift+4".action.move-column-to-monitor = 4;
        # "Mod+Ctrl+Shift+5".action.move-column-to-monitor = 5;
        # "Mod+Ctrl+Shift+6".action.move-column-to-monitor = 6;
        # "Mod+Ctrl+Shift+7".action.move-column-to-monitor = 7;
        # "Mod+Ctrl+Shift+8".action.move-column-to-monitor = 8;
        # "Mod+Ctrl+Shift+9".action.move-column-to-monitor = 9;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        "Mod+C".action = center-column;
      };
    };
  };
}
