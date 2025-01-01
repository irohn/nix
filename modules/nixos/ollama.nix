{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    piper-tts
    alsa-utils
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  services.open-webui = {
    enable = true;
  };
}
