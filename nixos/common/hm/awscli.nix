{ pkgs, config, ... }:
{

  programs.awscli = {
    enable = true;
    package = pkgs.awscli2;
    settings = {
      "default" = {
        region = "us-east-1";
        output = "json";
      };
      "profile nova" = {
        region = "us-east-1";
        role_arn = "arn:aws:iam::526463691898:role/tc-nova-k8s-developers-role";
        source_profile = "default";
      };
    };
    credentials = {
      "default" = {
        "credential_process" = "${pkgs.coreutils}/bin/cat ${config.age.secrets.aws-secrets.path}";
      };
    };
  };
}
