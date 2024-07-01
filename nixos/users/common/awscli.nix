{ pkgs, secrets, lib, inputs, system, ... }: {
  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        region = secrets.aws_region or "";
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "aws_access_key_id" = secrets.aws_access_key_id or "";
        "aws_secret_access_key" = secrets.aws_secret_access_key or "";
      };
    };
  };
}
