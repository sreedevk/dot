{

  hostname = "odoo";
  adminUID = "1000";
  adminGID = "1000";
  paths = { };
  nameservers = [ ];
  gpuaccel = "mesa";

  monitors = [
    {
      name = "eDP-1";
      desc = "Lenovo Group Limited MNE007JA1-3";
      resolution = { x = 1920; y = 1200; };
      position = { x = 0; y = 0; };
      rate = 60;
      scale = 1;
      bitdepth   = 10;
    }
  ];

  ports = {
  };
}
