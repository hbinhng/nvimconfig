local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    php = { "php-cs-fixer" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },

    -- css = { "prettierd" },
    -- html = { "prettierd" },
  },
  formatters = {
    php = {
      inherit = false,
      command = "php-cs-fixer",
      args = { "fix", "--rule=", "$FILENAME" },
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 5000,
    lsp_format = "fallback",
  },
}

require("conform").setup(options)
