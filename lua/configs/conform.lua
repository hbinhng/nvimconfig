local prettier = "prettierd"

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    php = { "php-cs-fixer" },
    javascript = { prettier },
    typescript = { prettier },
    javascriptreact = { prettier },
    typescriptreact = { prettier },
    css = { prettier },
    html = { prettier },
    json = { prettier },
    cs = { "csharpier" },
  },
  formatters = {
    php = {
      inherit = false,
      command = "php-cs-fixer",
      args = { "fix", "--rule=", "$FILENAME" },
    },
    zls = {
      inherit = false,
      command = "zig",
      args = { "fmt", "$FILENAME" },
    },
    csharpier = {
      command = "csharpier",
      args = { "format", "--write-stdout" },
    },
  },
  format_on_save = {
    timeout_ms = 5000,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
