# Cross-shell prompt with extensive customization options
{ dotfiles, use_stow, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file =
    if !use_stow then
      {
        ".config/starship.toml" = {
          source = "${dotfiles}/config/starship/starship.toml";
        };
      }
    else
      { };
}
