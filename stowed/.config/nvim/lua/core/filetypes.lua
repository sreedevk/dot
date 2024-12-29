vim.filetype.add {
  extension = {
    h = "c",
    CSV = "csv",
    scheme = "scheme",
    ex = "elixir",
    exs = "elixir",
    journal = "ledger",
    prices = "ledger",
    ledger = "ledger",
    envrc = "bash",
    eex = "heex",
    heex = "heex",
    leex = "leex",
    sface = "heex",
    lexs = "heex",
    janet = "janet"
  },
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
    ["mix.lock"] = "elixir"
  },
}
