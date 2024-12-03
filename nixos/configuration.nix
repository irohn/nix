{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./modules/host-users.nix
    ./modules/networking.nix
    ./modules/system.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable unpatched dynamic binaries on NixOS
  programs.nix-ld.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    curl
    git
  ];

  age = {
    identityPaths = [ "/etc/ssh/id_ed25519" ];
    secrets = {
      master_password = {
        file = ../secrets/master_password;
      };
      anthropics_api_key = {
        file = ../secrets/anthropics_api_key;
        mode = "0644";
      };
      openai_api_key = {
        file = ../secrets/openai_api_key;
        mode = "0644";
      };
    };
  };

  environment.variables = {
    ANTHROPIC_API_KEY = ''
        $(${pkgs.coreutils}/bin/cat ${config.age.secrets.anthropics_api_key.path})
    '';
    OPENAI_API_KEY = ''
        $(${pkgs.coreutils}/bin/cat ${config.age.secrets.openai_api_key.path})
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.05"; # Did you read the comment?
}
