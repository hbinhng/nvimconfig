local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local conform = require "conform"

local servers = {
  "html",
  "cssls",
  "tsserver",
  "phpactor",
  "tailwindcss",
  "clangd",
  "jdtls",
  "prismals",
  "jsonls",
  "csharp_ls",
  "gopls",
  "protols",
}

local enhanced_on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function()
        conform.format { bufnr = bufnr }
      end,
    })
  end
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = enhanced_on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.zls.setup {
  on_attach = enhanced_on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "zls" },
  filetypes = { "zig", "zon" },
  root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git"),
}
