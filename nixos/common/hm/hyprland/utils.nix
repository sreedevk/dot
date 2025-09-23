rec {
  genNested =
    namespace: confs:
    let
      arraytransformer = value: "${namespace} = ${value}";

      settransformer =
        key: value:
        if builtins.typeOf value == "string" then
          "${namespace}:${key} = ${value}"
        else
          genNested "${namespace}:${key}" value;
    in
    if builtins.typeOf confs == "set" then
      builtins.attrValues (builtins.mapAttrs settransformer confs)
    else
      builtins.map arraytransformer confs;
}
