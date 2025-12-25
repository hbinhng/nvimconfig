-- Floating LazyGit terminal
local function open_lazygit_float()
  -- Create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  -- Floating window size (80% of editor)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- Start lazygit in terminal
  vim.fn.termopen("lazygit", {
    on_exit = function()
      -- Close window safely on exit
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  -- Enter insert mode for terminal interaction
  vim.cmd "startinsert"
end

-- Keybinding: <leader>gw
vim.keymap.set("n", "<leader>gw", open_lazygit_float, { desc = "Open LazyGit (floating)" })
