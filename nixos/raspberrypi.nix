{
  config,
  pkgs,
  lib,
  ...
}: let
  timeZone = "Asia/Jerusalem";
  defaultLocale = "en_US.UTF-8";
in {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    fluxcd
  ];

  time.timeZone = timeZone;

  i18n = {
    defaultLocale = defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_MONETARY = defaultLocale;
      LC_NAME = defaultLocale;
      LC_NUMERIC = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_TIME = defaultLocale;
    };
  };

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  boot.kernelParams = [ "cgroup_enable=memory" "cgroup_enable=cpuset" "cgroup_memory=1" ];

  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    # 8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];
  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    "--write-kubeconfig-mode=644"
  ];

  services.tailscale.enable = true;

  environment.variables = {
      KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
    };

  system.stateVersion = "24.05";
}
