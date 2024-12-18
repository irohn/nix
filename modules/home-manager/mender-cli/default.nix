{
  pkgs,
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "mender-cli";
  version = "1.12.0";
  system = if pkgs.stdenv.isDarwin then "darwin" else "linux";

  src = fetchurl {
    url = "https://downloads.mender.io/mender-cli/${version}/${system}/mender-cli";
    sha256 = "";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  unpackPhase = ":";

  installPhase = ''
    runHook preInstall

    install -D $src $out/bin/mender-cli
    chmod +x $out/bin/mender-cli

    runHook postInstall
  '';

  meta = with lib; {
    description = "Command-line interface for Mender";
    homepage = "https://mender.io";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
