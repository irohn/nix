{ config, pkgs, lib, ... }:

let
  hostname = "pinix";
  user = "ori";
  password = "123456";
  nixosHardwareVersion = "7f1836531b126cfcf584e7d7d71bf8758bb58969";

  timeZone = "Asia/Jerusalem";
  defaultLocale = "en_US.UTF-8";
in {
  imports = ["${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/${nixosHardwareVersion}.tar.gz" }/raspberry-pi/4"];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = hostname;
    firewall.allowedTCPPorts = [
      6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
      # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
    ];
    firewall.allowedUDPPorts = [
      # 8472 # k3s, flannel: required if using multi-node for inter-node networking
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    fluxcd
  ];

  services = {
    openssh.enable = true;
    k3s = {
      enable = true;
      role = "server";
      extraFlags = toString [
        "--write-kubeconfig-mode=644"
      ];
    };
  };

  time.timeZone = timeZone;

  i18n = {
    inherit defaultLocale;
    extraLocaleSettings = with defaultLocale; {
      inherit
      LC_ADDRESS
      LC_IDENTIFICATION
      LC_MEASUREMENT
      LC_MONETARY
      LC_NAME
      LC_NUMERIC
      LC_PAPER
      LC_TELEPHONE
      LC_TIME;
    };
  };

  users = {
    mutableUsers = false;
    users."${user}" = { inherit password;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  # Enable passwordless sudo.
  security.sudo.extraRules= [
    {  users = [ user ];
      commands = [
         { command = "ALL" ;
           options= [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  boot.kernelParams = [ "cgroup_enable=memory" "cgroup_enable=cpuset" "cgroup_memory=1" ];


  environment.variables = {
      KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
    };


  system.stateVersion = "23.11";
}
