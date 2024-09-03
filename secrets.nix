let
  ori = [
    # public keys
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPjGVE8CXIupUSSzv7gX25FOM7u6AMWG63LeJKX2EmX6" # irohn
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICREe77Tw/a2lXSDgMi6sS/a4U3m/CamEsyVEheIu8FO" # macbook
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFRgZJvd679bdOO+9W5umSX4JxLzCsztZvzuREOfc/E9" # wsl-ubuntu
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKmdDp+AczoOuFgt2NM54EEIYa7U3ZNgjHWCe19J5n6p" # pinix
  ];

in
{
  "secrets/ori/device_password".publicKeys = ori;
  "secrets/flux_token".publicKeys = ori;
}
