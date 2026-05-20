_: with builtins; {
  age.secrets =
    foldl'
      (
        acc: elem:
        acc
        // {
          "${elem}" = {
            file = ../../../secrets/odoo/${elem}.age;
          };
        }
      )
      { }
      [
        "gh_token"
        "ghcr_ro_token"
      ];
}
