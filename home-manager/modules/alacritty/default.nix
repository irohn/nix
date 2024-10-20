{
  ...
}: {
  programs.alacritty = {
    enable = true;

    settings = {

      window = {
        decorations = "None";
        opacity = 1.0;
        blur = true;
        startup_mode = "Maximized";
        title = "Terminal";
      };
      
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 18;
      };

      bell = { command = "None"; };

      selection.save_to_clipboard = true;

    };
  };
}
