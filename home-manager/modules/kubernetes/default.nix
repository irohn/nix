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

        unalias kd 2>/dev/null
        kd() {
          local query=""
          local resource_type="pod"
          local kubectl_args=()

          while [[ $# -gt 0 ]]; do
            case "$1" in
              -q|--query)
                query="$2"
                shift 2
                ;;
              -t|--type)
                resource_type="$2"
                shift 2
                ;;
              *)
                kubectl_args+=("$1")
                shift
                ;;
            esac
          done

          if [[ -z $resource_type ]]; then
            echo "Error: Resource type is required. Use -t or --type to specify (e.g., pod, deployment, statefulset)."
            return 1
          fi

          local selected_resource=$(kubectl get $resource_type --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name --no-headers | 
            fzf --select-1 --query="$query")

          if [[ -n $selected_resource ]]; then
            local namespace=$(echo $selected_resource | awk '{print $1}')
            local resource_name=$(echo $selected_resource | awk '{print $2}')
            kubectl describe -n "$namespace" "$resource_type" "$resource_name" "''${kubectl_args[@]}"
          else
            echo "No $resource_type selected."
          fi
        }

        unalias kexec 2>/dev/null
        kexec() {
          local query=""
          local shell="/bin/sh"
          local kubectl_args=()

          while [[ $# -gt 0 ]]; do
            case "$1" in
              -q|--query)
                query="$2"
                shift 2
                ;;
              -s|--shell)
                shell="$2"
                shift 2
                ;;
              *)
                kubectl_args+=("$1")
                shift
                ;;
            esac
          done

          local selected_pod=$(kubectl get pods --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,POD:.metadata.name --no-headers | 
            fzf --select-1 --query="$query")

          if [[ -n $selected_pod ]]; then
            local namespace=$(echo $selected_pod | awk '{print $1}')
            local pod_name=$(echo $selected_pod | awk '{print $2}')

            local containers=$(kubectl get pod -n "$namespace" "$pod_name" -o jsonpath='{.spec.containers[*].name}')
            local container_count=$(echo "$containers" | wc -w)

            if [[ $container_count -eq 1 ]]; then
              local container=$containers
            else
              local container=$(echo "$containers" | tr ' ' '\n' | fzf --select-1 --header="Select container")
            fi

            if [[ -n $container ]]; then
              echo "Executing into $namespace/$pod_name:$container"
              kubectl exec -it -n "$namespace" "$pod_name" -c "$container" "''${kubectl_args[@]}" -- $shell
            else
              echo "No container selected."
            fi
          else
            echo "No pod selected."
          fi
        }
      '';
    };
  };
}
