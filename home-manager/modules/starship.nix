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
        style_user = "bright-green bold";
        style_root = "bright-red bold";
        show_always = true;
        format = "[$user]($style)";
      };
      nix_shell = {
        symbol = "❄️ ";
        format = "[$symbol$state]($style) ";
      };
      hostname = {
        ssh_symbol = "->ssh";
        ssh_only = false;
        format = "[@$hostname$ssh_symbol](bold green) ";
      };
      directory = {
        format = "[󰉋 $path]($style)[$read_only]($read_only_style) ";
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
