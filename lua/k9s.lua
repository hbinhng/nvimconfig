-- Floating k9s terminal with kubeconfig picker

local data_file = vim.fn.stdpath "data" .. "/k9s_kubeconfigs.json"

local function load_kubeconfigs()
  local f = io.open(data_file, "r")
  if not f then
    return {}
  end
  local content = f:read "*a"
  f:close()
  if content == "" then
    return {}
  end
  local ok, configs = pcall(vim.json.decode, content)
  if not ok then
    return {}
  end
  return configs
end

local function save_kubeconfigs(configs)
  local f = io.open(data_file, "w")
  if not f then
    return
  end
  f:write(vim.json.encode(configs))
  f:close()
end

local function open_k9s_float(kubeconfig)
  if vim.g._k9s_open then
    return
  end
  vim.g._k9s_open = true

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  local cmd = "k9s"
  if kubeconfig and kubeconfig ~= "" then
    cmd = cmd .. " --kubeconfig " .. vim.fn.shellescape(kubeconfig)
  end

  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.g._k9s_open = false
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  vim.cmd "startinsert"
end

local function pick_kubeconfig()
  local configs = load_kubeconfigs()

  local items = {}
  for _, path in ipairs(configs) do
    table.insert(items, path)
  end
  table.insert(items, "[Default (~/.kube/config)]")
  table.insert(items, "[Enter new kubeconfig path]")

  vim.ui.select(items, {
    prompt = "Select kubeconfig for k9s:",
  }, function(choice)
    if not choice then
      return
    end

    if choice == "[Default (~/.kube/config)]" then
      open_k9s_float(nil)
    elseif choice == "[Enter new kubeconfig path]" then
      vim.schedule(function()
        local path = vim.fn.input("Kubeconfig path: ", "", "file")
        if path == "" then
          return
        end
        path = vim.fn.expand(path)
        -- Prepend to history, dedup
        local new_configs = { path }
        for _, existing in ipairs(configs) do
          if existing ~= path then
            table.insert(new_configs, existing)
          end
        end
        save_kubeconfigs(new_configs)
        open_k9s_float(path)
      end)
    else
      -- Move selected to top of history
      local new_configs = { choice }
      for _, existing in ipairs(configs) do
        if existing ~= choice then
          table.insert(new_configs, existing)
        end
      end
      save_kubeconfigs(new_configs)
      open_k9s_float(choice)
    end
  end)
end

vim.keymap.set("n", "<leader>kctl", pick_kubeconfig, { desc = "Open k9s (floating)" })
