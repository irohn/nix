{
  pkgs,
  config,
  username,
  ...
}: {
  # Define a user account
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable 'sudo' for the user
    hashedPasswordFile = config.age.secrets.master_password.path;
    shell = pkgs.zsh;
  };
}
