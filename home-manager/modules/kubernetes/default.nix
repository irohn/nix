# Container orchestration platform configuration
{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubectx
    fluxcd
    kubernetes-helm
  ];

  programs = {
    zsh = {
      shellAliases = lib.mkIf config.programs.zsh.enable {
        k = "kubectl";
        pods = "kubectl get pods --all-namespaces";
        wp = "watch -n 0.1 'kubectl get pods --all-namespaces'";
        fl = "flux logs --all-namespaces";
        fra = "flux reconcile kustomization flux-system --with-source";
      };

      initExtra = lib.mkAfter ''
        unalias kl 2>/dev/null
        kl() {
          kubectl logs -n $(kubectl get pods --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name --no-headers | fzf --select-1) "''${@}"
        }
      '';
    };
  };
}
