{

  hostname      = "phoenix";
  adminUID      = "1000";
  adminGID      = "1000";
  paths         = { };
  nameservers   = [ ];
  gpuaccel      = "cuda";
  nvidiaVersion = "595.71.05";

  monitors = [
    {
      name       = "eDP-1";
      desc       = "Samsung Display Corp. 0x4177";
      resolution = { x = 3840; y = 2400; };
      position   = { x = 0; y = 0; };
      rate       = 60;
      scale      = 2;
      # bitdepth   = 10;
    }
  ];

  ports = {
    supervisord = "8843";
  };
}
