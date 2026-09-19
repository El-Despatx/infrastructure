{
  services.borgbackup.repos = {
    albus = {
      path = "/data/backups/albus";

      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUGgbJoQzz+kfMMH/XDSDqeS9IixW6sUYp4c8d9+XRL"
      ];
    };
    dobby = {
      path = "/data/backups/dobby";

      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMD+BVoBJLoeTuElfwnmJ++ePHk9G/lm1wZy1VbRvOq7"
      ];
    };
    elrond = {
      path = "/data/backups/elrond";

      authorizedKeysAppendOnly = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILtT0z+lLKh5Dx6PIYJUAaQQ/gV/VZrhDw6nmdakz2wo notahuman@elrond"
      ];

      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMwPiy0p4GqkQ8lQpU7WjZ95U7H5xIisuC7Cu/Hgk8wr cardno:25_555_331" # pablo
      ];
    };
  };
}
