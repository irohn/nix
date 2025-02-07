{
  pkgs,
  config,
  lib,
  ...
}:

{
  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
  age.secrets = {
    anthropics_api_key = {
      file = ../../../secrets/anthropics_api_key;
      mode = "644";
    };
    openai_api_key = {
      file = ../../../secrets/openai_api_key;
      mode = "644";
    };
  };

  home.sessionVariables = {
    ANTHROPIC_API_KEY = "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.anthropics_api_key.path})";
    OPENAI_API_KEY = "$(${pkgs.coreutils}/bin/cat ${config.age.secrets.openai_api_key.path})";
  };
  programs.zsh.initExtra = lib.mkIf config.programs.zsh.enable ''
    export ANTHROPIC_API_KEY="$(${pkgs.coreutils}/bin/cat ${config.age.secrets.anthropics_api_key.path})"
    export OPENAI_API_KEY="$(${pkgs.coreutils}/bin/cat ${config.age.secrets.openai_api_key.path})"
  '';
}
