opam env | lines | split column ';' vars | get vars | parse "{var}='{value}'" | transpose --header-row --as-record | load-env
