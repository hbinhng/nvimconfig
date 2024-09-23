require "nvchad.mappings"

-- add yours here

local cmp = require "cmp"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-G>", cmp.mapping.complete())

map("n", "<leader>cp", function()
  vim.cmd 'let @" = expand("%")'
end, {
  desc = "Quick copy current file path to unamed register",
  noremap = true,
  silent = true,
})

map("n", "<leader>gaf", function()
  vim.cmd ':!git add "%"'
end, {
  desc = "Quick add current file to git staging index",
  noremap = true,
  silent = true,
})

map("n", "<leader>gad", function()
  vim.cmd ':!git add "%:h"'
end, {
  desc = "Quick add current folder to git staging index",
  noremap = true,
  silent = true,
})

map("n", "<leader>gcm", function()
  vim.ui.input({
    prompt = "Enter commit message: ",
  }, function(message)
    if message == nil then
      return
    end

    vim.system({ "git", "commit", "-m", message }, { text = true }):wait()
  end)
end, {
  desc = "Quick amend commit without editing",
  noremap = true,
  silent = true,
})

map("n", "<leader>gca", function()
  vim.cmd ":!git commit --amend --no-edit"
end, {
  desc = "Quick amend commit without editing",
  noremap = true,
  silent = true,
})

map("n", "<leader>gp", function()
  vim.cmd ":!git push"
end, {
  desc = "Quick git push",
  noremap = true,
  silent = true,
})

map("n", "<leader>tt", function()
  vim.cmd ":term"
end, {
  desc = "Quick open terminal in new tab",
  noremap = true,
  silent = true,
})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
