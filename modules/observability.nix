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
        "/dev/disk/by-id/wwn-0x600508b1001cebd3cb9241b484b91f97"
        "/dev/disk/by-id/wwn-0x600508b1001c8defb80b6bf96bc5781f"
      ];
      extraFlags = [ ];
      openFirewall = false;
    };
  };
}
