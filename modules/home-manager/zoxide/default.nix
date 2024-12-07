# A smarter cd command that learns your habits
{ ... }:

{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
}
