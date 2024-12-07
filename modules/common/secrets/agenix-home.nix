{ pkgs, config, ... }:

{
  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
  age.secrets = {
    anthropics_api_key = {
      file = ./anthropics_api_key;
      mode = "644";
    };
    openai_api_key = {
      file = ./openai_api_key;
      mode = "644";
    };
  };

  home.sessionVariables = {
    ANTHROPIC_API_KEY = ''
        $(${pkgs.coreutils}/bin/cat ${config.age.secrets.anthropics_api_key.path})
    '';
    OPENAI_API_KEY = ''
        $(${pkgs.coreutils}/bin/cat ${config.age.secrets.openai_api_key.path})
    '';
  };
}
