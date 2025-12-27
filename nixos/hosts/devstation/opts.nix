{

  hostname      = "devstation";
  adminUID      = "1000";
  adminGID      = "1000";
  lanAddress    = "192.168.1.249";
  paths         = { };
  nameservers   = [ ];
  gpuaccel      = "cuda";
  nvidiaVersion = "590.48.01";

  monitors = [
    {
      name       = "eDP-1";
      desc       = "AU Optronics 0xF99A";
      resolution = { x = 1920; y = 1200; };
      position   = { x = 0; y = 1080; };
      rate       = 60;
      scale      = 1;
      # bitdepth = 10;
    }
    {
      name       = "DP-3";
      desc       = "XEC ES-24X3A 0x00000022";
      resolution = { x = 1920; y = 1080; };
      position   = { x = 0; y = 0; };
      rate       = 100.00;
      scale      = 1;
      # bitdepth = 10;
    }
    {
      name       = "DP-2";
      desc       = "LG Electronics LG Ultra HD 0x00073F78";
      resolution = { x = 3840; y = 2160; };
      position   = { x = 1920; y = 0; };
      rate       = 60;
      scale      = 1.6;
      # bitdepth = 10;
    }
  ];

  ports = {
    supervisord = "8843";
  };
}
