{ pkgs, secrets, lib, inputs, system, ... }: {
  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = secrets.aws.config.region;
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "aws_access_key_id" = secrets.aws.credentials.aws_access_key_id;
        "aws_secret_access_key" = secrets.aws.credentials.aws_secret_access_key;
      };
    };
  };
}
