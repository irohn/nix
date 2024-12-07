{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../modules/darwin/system.nix
    ../../modules/darwin/host-users.nix
    ../../modules/darwin/apps.nix
    ../../modules/darwin/window-manager.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  # make default mac zsh align with nixpkgs
  programs.zsh.enable = true;

  age.secrets = {
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

  environment.variables = {
    ANTHROPIC_API_KEY = ''
        $(${pkgs.coreutils}/bin/cat ${config.age.secrets.anthropics_api_key.path})
    '';
    OPENAI_API_KEY = ''
        $(${pkgs.coreutils}/bin/cat ${config.age.secrets.openai_api_key.path})
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  system.stateVersion = 4;
}
