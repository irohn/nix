{ pkgs, ... }:

let
  hcp = pkgs.buildGoModule rec {
    pname = "hcp";
    version = "0.8.0";
    src = pkgs.fetchFromGitHub {
      owner = "hashicorp";
      repo = "hcp";
      rev = "v${version}";
      sha256 = "sha256-YOOaQh1OsRn5EV9RmUdWWdHx5bMFC+a1qFzUGb6lpew=";
    };
    vendorHash = "sha256-/Nf180odZB5X3Fj4cfz0TdYEfGKtkkh4qI9eRfz+meQ=";
    doCheck = false;
    nativeCheckInputs = with pkgs; [ less ];
  };
in
  {
  home.packages = with pkgs; [
    hcp
  ];
}
