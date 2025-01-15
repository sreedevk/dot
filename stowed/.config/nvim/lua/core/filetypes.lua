vim.filetype.add {
  extension = {
    h = "c",
    CSV = "csv",
    lock = 'yaml',
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
    ['NEOGIT_COMMIT_EDITMSG'] = 'NeogitCommitMessage',
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
    ["mix.lock"] = "elixir"
  },
  pattern = {
    ['.*%.conf'] = 'conf',
    ['.*%.theme'] = 'conf',
    ['.*%.gradle'] = 'groovy',
    ['^.env%..*'] = 'bash',
  },
}
