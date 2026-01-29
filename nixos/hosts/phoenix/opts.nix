{

  hostname      = "phoenix";
  adminUID      = "1000";
  adminGID      = "1000";
  lanAddress    = "192.168.1.235";
  paths         = { };
  nameservers   = [ ];
  gpuaccel      = "cuda";
  nvidiaVersion = "590.48.01";

  monitors = [

    # monitor = desc:Samsung Display Corp. 0x4177,3840x2400@60.00,-150x1450,2.00000000,transform,0
    # monitor = desc:LG Electronics LG Ultra HD 0x00073F78,3840x2160@60.00,1820x0,1.60000000,transform,0
    # monitor = desc:XEC ES-24X3A 0x00000022,1920x1080@100.00,-150x0,1.00000000,transform,0
    {
      name       = "eDP-1";
      desc       = "Samsung Display Corp. 0x4177";
      resolution = { x = 3840; y = 2400; };
      position   = { x = -150; y = 1450; };
      rate       = 60;
      scale      = 2;
      # bitdepth = 10;
    }
    {
      name       = "DP-3";
      desc       = "XEC ES-24X3A 0x00000022";
      resolution = { x = 1920; y = 1080; };
      position   = { x = -150; y = 0; };
      rate       = 100.00;
      scale      = 1;
      # bitdepth = 10;
    }
    {
      name       = "DP-2";
      desc       = "LG Electronics LG Ultra HD 0x00073F78";
      resolution = { x = 3840; y = 2160; };
      position   = { x = 1820; y = 0; };
      rate       = 60;
      scale      = 1.6;
      # bitdepth = 10;
    }
  ];

  ports = {
    supervisord = "8843";
  };
}
