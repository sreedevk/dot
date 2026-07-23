{
  # TODO: key needs to be obtained using `attic use <cache-name> output`
  # attic = {
  #   key = "${hostname}:1g5EwMSBZ+JzIDnDwyUCviXR70AAzAdkVBs0k0+GRPw=";
  #   url = "https://attic.nullptr.sh/${hostname}";
  # };
  hostname = "phoenix";
  adminUID = "1000";
  adminGID = "1000";
  paths = { };
  nameservers = [ ];
  gpuaccel = "cuda";
  nvidiaVersion = "595.71.05";
  ports = {
    supervisord = "8843";
  };

  taskwarrior.sync = {
    serverAddress = "https://tasks.nullptr.sh";
    clientID = "$TASKWARRIOR_CLIENT_ID";
    encryptionSecret = "$TASKWARRIOR_ENCRYPTION_SECRET";
    frequency = "30min";
  };
}
