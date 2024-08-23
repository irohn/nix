{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubectx
    azure-cli
  ];
}
