{ pkgs, secrets, lib, inputs, system, utils, ... }: {
  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = secrets.aws_region or utils.randStr;
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "aws_access_key_id" = secrets.aws_access_key_id or utils.randStr;
        "aws_secret_access_key" = secrets.aws_secret_access_key or utils.randStr;
      };
    };
  };
}
