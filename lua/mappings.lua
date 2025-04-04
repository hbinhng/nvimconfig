require "nvchad.mappings"

-- add yours here

local cmp = require "cmp"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-G>", cmp.mapping.complete())

map("n", "<leader>fg", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, {
  desc = "telescope live grep (args)",
  noremap = true,
  silent = true,
})

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

    vim.system({ "git", "commit", "-m", message, "--allow-empty" }, { text = true }):wait()
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

map("n", "<leader>tb", function()
  vim.cmd "BookmarksMark"
end, {
  desc = "Toggle bookmark",
  noremap = true,
  silent = true,
})

map("n", "<leader>bl", function()
  vim.cmd "BookmarksGoto"
end, {
  desc = "List all bookmarks",
  noremap = true,
  silent = true,
})

map("n", "<leader>cla", function()
  vim.cmd "%bd"
end, {
  desc = "Close all buffers",
  noremap = true,
  silent = true,
})

map("n", "<leader>clo", function()
  vim.cmd "%bd|e#"
end, {
  desc = "Close all buffers except current",
  noremap = true,
  silent = true,
})

map("n", "<leader>clx", function()
  vim.cmd "bufdo if &buftype == '' | bd | endif"
end, {
  desc = "Close all text buffers",
  noremap = true,
  silent = true,
})
