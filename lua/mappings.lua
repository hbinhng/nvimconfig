require "nvchad.mappings"

-- add yours here

local cmp = require "cmp"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-G>", cmp.mapping.complete())

map("n", "<leader>tt", function()
  vim.cmd ":term"
end, {
  desc = "Quick open terminal in new tab",
  noremap = true,
  silent = true,
})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
