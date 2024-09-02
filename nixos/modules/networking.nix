{ config, lib, pkgs, hostname, ... }:

{
  networking = {
    hostName = hostname; # Define your hostname.
    networkmanager.enable = true; # Enables wireless support via NetworkManager.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ 22 80 443 ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    # Permit root login through SSH to set-up the system
    # Remember to disable this after initial setup!
    permitRootLogin = "yes";
    # Use keys only. Remove this if you want to SSH using a password
    passwordAuthentication = true;
  };
}
