require "nvchad.options"
require "performance"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.mouse = ""

vim.o.number = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakat = " \t!@*?.,;:"

vim.o.winblend = 25

require("nvim-tree").setup {
  sort = { sorter = "case_sensitive" },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  view = {
    preserve_window_proportions = true,
    number = true,
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = function()
        local min_desired = 60
        local max_actual = math.min(vim.o.columns - 2, min_desired)
        local width = math.max(math.floor(vim.o.columns * 0.4), max_actual)
        local height = math.floor(vim.o.lines * 0.6)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        return {
          relative = "editor",
          border = "rounded",
          width = width,
          height = height,
          row = row,
          col = col,
        }
      end,
    },
  },
}
