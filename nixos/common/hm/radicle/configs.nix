let
  genconf = alias: {
    publicExplorer = "https://app.radicle.xyz/nodes/$host/$rid$path";
    preferredSeeds = [
      "z6MktfuMmbEPd6tHVELEeQqUn9hHHDo2FpiuENrMPqQUV9pB@seed.devtechnica.com:8776"
      "z6MkrLMMsiPWUcNPHcRajuMi9mDfYckSoJyPwwnknocNYPm7@iris.radicle.xyz:8776"
      "z6Mkmqogy2qEM2ummccUthFEaaHvyYmYBYh3dbe9W4ebScxo@rosa.radicle.xyz:8776"
    ];
    web = {
      pinned = {
        repositories = [ ];
      };
    };
    cli = {
      hints = true;
    };
    node = {
      inherit alias;
      listen = [ ];
      peers = {
        type = "dynamic";
      };
      connect = [ ];
      externalAddresses = [ ];
      network = "main";
      log = "INFO";
      relay = "auto";
      limits = {
        routingMaxSize = 1000;
        routingMaxAge = 604800;
        gossipMaxAge = 1209600;
        fetchConcurrency = 1;
        maxOpenFiles = 4096;
        rate = {
          inbound = {
            fillRate = 5.0;
            capacity = 1024;
          };
          outbound = {
            fillRate = 10.0;
            capacity = 2048;
          };
        };
        connection = {
          inbound = 128;
          outbound = 16;
        };
        fetchPackReceive = "500.0 MiB";
      };
      workers = 8;
      seedingPolicy = {
        default = "block";
      };
    };
  };
in
{
  "pi@rpi4b" = builtins.toJSON (genconf "radpi");
  "sreedev@devstation" = builtins.toJSON (genconf "sreedev");
  "deploy@devtechnica" = builtins.toJSON (genconf "devtk");
  "sreedev@apollo" = builtins.toJSON (genconf "devbox");
}
