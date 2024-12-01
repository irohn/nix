let
  ori = [
    # public keys (user level ~/.ssh)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICREe77Tw/a2lXSDgMi6sS/a4U3m/CamEsyVEheIu8FO" # macbook
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFRgZJvd679bdOO+9W5umSX4JxLzCsztZvzuREOfc/E9" # wsl-ubuntu
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmdDp+AczoOuFgt2NM54EEIYa7U3ZNgjHWCe19J5n6p" # pinix
  ];
  systems = [
    # public keys (system level /etc/ssh)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPjGVE8CXIupUSSzv7gX25FOM7u6AMWG63LeJKX2EmX6" # github (1password)
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPdFUkUYAgMzaGpSDRa35Dm8Ti+i8wX9Utbyk6yiB+w3" # macbook pro
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEF/kDDUaylmFWqlgaBsuHVNUwunJk6beHmC0jur8raY" # Raspberry pi
  ];

in
{
  "secrets/master_password".publicKeys = ori ++ systems;
  "secrets/anthropics_api_key".publicKeys = ori ++ systems;
  "secrets/openai_api_key".publicKeys = ori ++ systems;
}
