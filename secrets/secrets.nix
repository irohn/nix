let
  macbook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFwWiiY7dTrYDKkRE2dJfZtSgFX3IBzxt6Z0YiPPL45A";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKN25wBIZ2UFyE4ygBeIlDjRX3zBy3E7O+2mldPBY9Gl";
  users = [ macbook desktop ];
in
{
  "anthropics_api_key".publicKeys = users;
  "openai_api_key".publicKeys = users;
}
