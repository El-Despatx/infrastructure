{ ... }:
{
  services.borgbackup.repos.albus = {
    path = "/data/backups/albus";

    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUGgbJoQzz+kfMMH/XDSDqeS9IixW6sUYp4c8d9+XRL"
    ];
  };
  services.borgbackup.repos.dobby = {
    path = "/data/backups/dobby";

    authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMD+BVoBJLoeTuElfwnmJ++ePHk9G/lm1wZy1VbRvOq7"
    ];
  };
}
