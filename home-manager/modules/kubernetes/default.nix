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
          local query=""
          local kubectl_args=()

          while [[ $# -gt 0 ]]; do
            case "$1" in
              -q|--query)
                query="$2"
                shift 2
                ;;
              *)
                kubectl_args+=("$1")
                shift
                ;;
            esac
          done

          local selected_pod=$(kubectl get pods --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name --no-headers | 
            fzf --select-1 --query="$query")

          if [[ -n $selected_pod ]]; then
            local namespace=$(echo $selected_pod | awk '{print $1}')
            local pod_name=$(echo $selected_pod | awk '{print $2}')
            kubectl logs -n "$namespace" "$pod_name" "''${kubectl_args[@]}"
          else
            echo "No pod selected."
          fi
        }
      '';
    };
  };
}
