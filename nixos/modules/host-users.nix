{
  pkgs,
  username,
  ...
}: {
  # Define a user account
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable 'sudo' for the user
    shell = pkgs.zsh;
    # passwordFile = "";
  };
}
