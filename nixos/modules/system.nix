{
  pkgs,
  ...
}: {
  programs = {
    zsh.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };
}
