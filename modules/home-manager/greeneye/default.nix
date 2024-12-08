# Custom module for greeneye specific needs
{ pkgs, lib, ... }:

{
  # Dependencies
  home.packages = with pkgs; [
    fd
    ripgrep
    tailscale
    azure-cli
    kubectl
    gawk
    fzf
  ];

  home.sessionVariables = {
    FLUXCD_REPO_NAME = "rt-versions";
    VAULT_ADDR = "https://sod.tail6954.ts.net/";
  };

  programs.zsh = {
    shellAliases = {
      whoarewe = "echo greeneye";
    };

    initExtra = lib.mkAfter /* bash */ ''
        find_rt_versions() {
          if ! command -v fd &> /dev/null; then
            echo "error: fd command not found"
            return 1
          fi
          local rt_versions_path=$(fd -1 -t d rt-versions$ "$HOME")
          echo $rt_versions_path
        }

        list_clusters() {
        if ! command -v rg &> /dev/null; then
          echo "error: rg command not found"
          return 1
        fi

        fd -t f 'cluster-vars-cm.yaml' "$1" -x sh -c '
          cluster_name=$(rg -m1 "CLUSTER_NAME:" {} | cut -d: -f2 | tr -d " \r")
          sprayer_group=$(rg -m1 "SPRAYER_GROUP:" {} | cut -d: -f2 | tr -d " \r")
          boom_location=$(rg -m1 "BOOM_LOCATION:" {} | cut -d: -f2 | sed "s/#.*$//" | tr -d " \r")
          printf "%s %s-%s\n" "$cluster_name" "$sprayer_group" "$boom_location"
        '
        }

        tailscale_clusters_match() {
          # Check if tailscale is installed
          if ! command -v tailscale &> /dev/null; then
            echo "error: tailscale command not found"
            return 1
          fi

          local kubeconfig="false"
          local query=""

          while [[ $# -gt 0 ]]; do
            case "$1" in
              -k|--kubeconfig)
                kubeconfig="true"
                shift
                ;;
              --)
                shift
                break
                ;;
              -*)
                echo "unknown option: $1" >&2
                return 1
                ;;
              *)
                # Collect non-option arguments for the query
                query+="$1 "
                shift
                ;;
            esac
          done

          # Collect any remaining arguments after '--' for the query
          query+="$* "
          # Trim trailing space from query
          query="''${query% }"

          local rt_versions_path=$(find_rt_versions)
          if [ -z "$rt_versions_path" ]; then echo "error: couldn't find rt-versions" && return 1; fi

          # get clusters information from rt-versions
          local clusters_info=$(list_clusters $rt_versions_path)

          # get device candidates from tailscale
          if [ "$kubeconfig" = "true" ]; then
            local clusters_information=$(tailscale status | gawk '/tagged-devices/ {if($2 !~ /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/) print $2 " " $NF}')
          else
            local clusters_information=$(tailscale status | gawk '/tagged-devices/ {if($2 ~ /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/) print $2 " " $NF}')
          fi

          selection=$(awk -v kubeconfig="$kubeconfig" '
          BEGIN {
              FS=" "
          }
          NR == FNR {
              clusters[$1] = $2
              next
          }
          {
              mac = $1
              status = $2
              if (kubeconfig == "true" && mac ~ /^k3s-/) {
                  mac_base = substr(mac, 5, 17)
                  num = substr(mac, 23)
                  if (num == "") num = 0
                  if (mac_base in seen) {
                      if (num > seen[mac_base]) {
                          seen[mac_base] = num
                          macs[mac_base] = mac
                      }
                  } else {
                      seen[mac_base] = num
                      macs[mac_base] = mac
                  }
              } else {
                  macs[mac] = mac
              }
              statuses[mac] = status
          }
          END {
              for (mac_base in macs) {
                  mac = macs[mac_base]
                  if (mac_base in clusters) {
                      print mac, clusters[mac_base], statuses[mac]
                  } else {
                      print mac, "unknown", statuses[mac]
                  }
              }
          }' <(echo "$clusters_info") <(echo "$clusters_information") | sort | fzf --select-1 --exit-0 --exact --query "$query")
          echo "$selection"
        }

        tssh() {
          selection=$(tailscale_clusters_match "''${@}")
          if [ ! -z "$selection" ]; then
            ssh -i "''${HOME}/.ssh/greenboard" green@$(echo "$selection" | cut -d " " -f1)
          else
            echo "error: empty selection"
            return 1
          fi
        }

        tkx() {
          if ! command -v kubectl &> /dev/null; then
            echo "error: kubectl command not found"
            return 1
          fi
          local selection=$(tailscale_clusters_match --kubeconfig "''${@}")
          if [ ! -z "$selection" ]; then
            tailscale configure kubeconfig $(echo "$selection" | cut -d " " -f1)
          else
            echo "error: empty selection"
            return 1
          fi
        }
    '';
  };
}
