{ pkgs, nixpkgs-stable, config, secrets, ... }: {

  programs.awscli = {
    enable = true;
    package = nixpkgs-stable.awscli2;
    settings = {
      "default" = {
        region = secrets.aws_region or "";
        output = "json";
      };
    };
    credentials = {
      "default" = {
        "aws_access_key_id" = "${builtins.readFile config.age.secrets.aws-acc-key-id.path}";
        "aws_secret_access_key" = secrets.aws_secret_access_key or "";
      };
    };
  };

}
