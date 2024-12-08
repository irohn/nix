# Cross-shell prompt with extensive customization options
{ dotfiles, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/starship.toml" = {
      source = "${dotfiles}/config/starship/starship.toml";
    };
  };
}
