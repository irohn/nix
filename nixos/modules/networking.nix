{
  hostname,
  ...
}: {
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
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };
    };

    tailscale.enable = true;
  };
}
