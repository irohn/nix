{ username, ... }:

{
  age.secrets.device_password = {
    file = "./secrets/${username}/device_password";
    owner = "${username}";
    group = "${username}";
  };

  # Define a user account
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable 'sudo' for the user
    passwordFile = "";
  };
}
