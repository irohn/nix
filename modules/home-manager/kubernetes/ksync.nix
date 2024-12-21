{ pkgs, ... }:

let
  ksync = pkgs.buildGoModule rec {
    pname = "ksync";
    version = "0.4.7-hotfix";
    src = pkgs.fetchFromGitHub {
      owner = "ksync";
      repo = "ksync";
      rev = "${version}";
      sha256 = "sha256-XOE6WSKPPqidKY77cXaFe6OvNr5PTHoLYNwFDHzMBAQ=";
    };
    vendorHash = "sha256-ioa9j2cAPUEm+6qpEI/zf+3QHBbkQyn3Z2LsCoDRTuI=";
    doCheck = false;
    nativeCheckInputs = with pkgs; [ less ];
  };
in
{
  home.packages = [
    ksync
  ];
}
