{
  pkgs,
  config,
  lib,
  ...
}:

{
  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    secrets = {
      pass_gpg_public = {
        file = ../../../secrets/pass_gpg_public;
        path = "${config.xdg.dataHome}/pass_gpg_public.asc";
      };
      pass_gpg_private = {
        file = ../../../secrets/pass_gpg_private;
        path = "${config.xdg.dataHome}/pass_gpg_private.asc";
      };
    };
  };

  programs = {
    password-store = {
      enable = true;
    };
    gpg = {
      enable = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  home.activation = {
    importGpgKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -f "${config.xdg.dataHome}/pass_gpg_public.asc" ]; then
        $DRY_RUN_CMD ${pkgs.gnupg}/bin/gpg --import "${config.xdg.dataHome}/pass_gpg_public.asc"
      fi
      if [ -f "${config.xdg.dataHome}/pass_gpg_private.asc" ]; then
        $DRY_RUN_CMD ${pkgs.gnupg}/bin/gpg --import "${config.xdg.dataHome}/pass_gpg_private.asc"
      fi
    '';
  };
}
