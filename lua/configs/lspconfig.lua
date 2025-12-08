local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local conform = require "conform"

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "phpactor",
  "tailwindcss",
  "clangd",
  "jdtls",
  "prismals",
  "jsonls",
  "csharp_ls",
  "gopls",
  "protols",
  "yamlls",
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
  vim.lsp.config(lsp, {
    on_attach = enhanced_on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })

  vim.lsp.enable(lsp)
end

vim.lsp.config("zls", {
  on_attach = enhanced_on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "zls" },
  filetypes = { "zig", "zon" },
  root_markers = { "zls.json", "build.zig", ".git" },
})
