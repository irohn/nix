# home-manager/starship.nix

{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$os$all";
      add_newline = false;
      line_break = { disabled = true; };
      username = {
        style_user = "bright-white bold";
        style_root = "bright-red bold";
      };
      nix_shell = {
        symbol = "";
        format = "[$symbol$name]($style) ";
        style = "bright-purple bold";
      };
      hostname = {
        ssh_symbol = " ";
        format = "[$ssh_symbol](bold white) [$hostname](bold green) ";
      };
      character = {
        success_symbol = "[\\$](bright-green bold)";
        error_symbol = "[\\$](bright-red bold)";
      };
      os = {
        disabled = false;
        format = " [$symbol](white)";
        symbols = {
          Alpaquita = " ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = "󰍲 ";
        };
      };
    };
  };
}
