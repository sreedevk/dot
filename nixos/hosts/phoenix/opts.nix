{

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
