{
  programs.niri.settings = {
    spawn-at-startup = [
      {command = ["alacritty"];}
      {command = ["waypaper" "--restore" "--backend swww" "--fill fit"];}
    ];
  };
}
