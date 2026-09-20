let
  address = "100.106.108.102"; # rebost tailscale ip
in
{
  services.prometheus.exporters = {
    node = {
      enable = true;
      listenAddress = address;
      port = 9100;
      enabledCollectors = [ "systemd" ];
      disabledCollectors = [ ];
      extraFlags = [ ];
      openFirewall = false;
    };

    smartctl = {
      enable = true;
      listenAddress = address;
      port = 9633;
      devices = [
        "/dev/sda;cciss,0"
        "/dev/sdb;cciss,0"
      ];
      extraFlags = [ ];
      openFirewall = false;
    };
  };
}
