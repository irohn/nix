let
  macbook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFwWiiY7dTrYDKkRE2dJfZtSgFX3IBzxt6Z0YiPPL45A";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKN25wBIZ2UFyE4ygBeIlDjRX3zBy3E7O+2mldPBY9Gl";
  wsl = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGga0B9lJdQ+TOyHZhIGuCzzqrTYq9sTelnMxcXUJJtQ";
  users = [ macbook desktop wsl ];
in
{
  "anthropics_api_key".publicKeys = users;
  "openai_api_key".publicKeys = users;
}
