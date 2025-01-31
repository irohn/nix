{ dotfiles, stow, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file =
    if !stow then
      {
        ".config/starship.toml" = {
          source = "${dotfiles}/config/starship/starship.toml";
        };
      }
    else
      { };
}
