let
  macbook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICREe77Tw/a2lXSDgMi6sS/a4U3m/CamEsyVEheIu8FO";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKN25wBIZ2UFyE4ygBeIlDjRX3zBy3E7O+2mldPBY9Gl";
  users = [ macbook desktop ];
in
{
  "anthropics_api_key".publicKeys = users;
  "openai_api_key".publicKeys = users;
}
