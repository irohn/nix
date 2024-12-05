# Cross-shell prompt with extensive customization options
{
  dotfiles,
  ...
}: {
  home.file = {
    ".config/starship.toml" = {
      source = "${dotfiles}/xdg/starship/starship.toml";
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
