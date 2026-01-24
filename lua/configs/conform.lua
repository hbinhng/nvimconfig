local prettier = "prettier"

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
    go = { "gofmt" },
    proto = { "buf" },
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
    gofmt = {
      command = "gofmt",
      args = { "-w", "$FILENAME" },
    },
    buf = {
      command = "buf",
      args = { "format", "-w", "$FILENAME" },
    },
  },
  format_on_save = {
    timeout_ms = 5000,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
