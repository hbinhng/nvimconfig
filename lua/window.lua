local map = vim.keymap.set

local resize_state = { last_time = 0, count = 0, last_key = "" }

local function accel_resize(cmd, key)
  return function()
    local now = vim.uv.hrtime() / 1e6
    if key == resize_state.last_key and (now - resize_state.last_time) < 300 then
      resize_state.count = resize_state.count + 1
    else
      resize_state.count = 1
    end
    resize_state.last_time = now
    resize_state.last_key = key
    local amount = resize_state.count >= 3 and 10 or 1
    vim.cmd(amount .. cmd)
  end
end

map("n", "<C-S-H>", accel_resize("wincmd <", "H"), { desc = "Reduce window width", noremap = true, silent = true })
map("n", "<C-S-J>", accel_resize("wincmd -", "J"), { desc = "Reduce window height", noremap = true, silent = true })
map("n", "<C-S-K>", accel_resize("wincmd +", "K"), { desc = "Increase window height", noremap = true, silent = true })
map("n", "<C-S-L>", accel_resize("wincmd >", "L"), { desc = "Increase window width", noremap = true, silent = true })
