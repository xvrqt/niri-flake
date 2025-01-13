{
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

  alienware = {
    output = "HDMI-A-1";
    mode = {
      width = 3440;
      height = 1440;
      refresh = 59.973;
    };
    variable-refresh-rate = false;
    scale = 1.0;
    position = {
      x = -3024;
      y = 0;
    };
    transform = {
      flipped = false;
      rotation = 0;
    };
  };

  # Mac Book Pro Screen
  mac-book-pro = {
    output = "eDP-1";
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
  };
}
