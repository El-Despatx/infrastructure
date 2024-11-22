{ user, ... }:
{
  services.openssh = {
    enable = true;
    # settings.PermitRootLogin = "no";
  };
}
