{ pkgs, nixpkgs-stable, config, secrets, ... }: {

  programs.awscli = {
    enable = true;
    package = nixpkgs-stable.awscli2;
    settings = {
      "default" = {
        region = secrets.aws_region or "us-east-1";
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "credential_process" = "${pkgs.coreutils}/bin/cat ${config.age.secrets.aws-secrets.path}";
        # "aws_access_key_id" = secrets.aws_access_key_id or "";
        # "aws_secret_access_key" = secrets.aws_secret_access_key or "";
      };
    };
  };
}
