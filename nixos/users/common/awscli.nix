{ pkgs, config, ... }: {

  programs.awscli = {
    enable = true;
    package = pkgs.awscli2;
    settings = {
      "default" = {
        region = "us-east-1";
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "credential_process" = "${pkgs.coreutils}/bin/cat ${config.age.secrets.aws-secrets.path}";
      };
    };
  };
}
