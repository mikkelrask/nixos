{ config, ... }:
{
  systemd.mounts = [
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "192.168.1.190:/data";
      where = "/data";
    }
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "192.168.1.190:/pool";
      where = "/pool";
    }
  ];

  systemd.automounts = [
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/data";
    }
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/pool";
    }
  ];
}
