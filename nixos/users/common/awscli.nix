{ pkgs, secrets, lib, inputs, system, ... }: {
  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = secrets.aws_region;
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "aws_access_key_id" = secrets.aws_access_key_id;
        "aws_secret_access_key" = secrets.aws_secret_access_key;
      };
    };
  };
}
