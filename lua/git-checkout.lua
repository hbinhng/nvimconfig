-- Git checkout with floating branch picker
-- Uses Telescope for branch search; creates new branch if not found

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function get_branches()
  local result = vim.system({ "git", "branch", "-a", "--format=%(refname:short)" }, { text = true }):wait()
  if result.code ~= 0 then
    return {}
  end

  local branches = {}
  local seen = {}
  for line in result.stdout:gmatch "[^\r\n]+" do
    -- Strip "origin/" prefix for remote branches to avoid duplicates
    local name = line:gsub("^origin/", "")
    if name ~= "HEAD" and not seen[name] then
      seen[name] = true
      table.insert(branches, name)
    end
  end
  table.sort(branches)
  return branches
end

local function checkout(branch, create)
  local args = create and { "git", "checkout", "-b", branch } or { "git", "checkout", branch }
  local result = vim.system(args, { text = true }):wait()

  if result.code == 0 then
    vim.notify((create and "Created and switched to " or "Switched to ") .. branch, vim.log.levels.INFO)
  else
    vim.notify("git checkout failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
  end
end

local function open_branch_picker()
  local branches = get_branches()

  pickers
    .new({}, {
      prompt_title = "Git Checkout",
      finder = finders.new_table { results = branches },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        -- Default action: checkout the selected branch
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          local prompt = action_state.get_current_line()
          actions.close(prompt_bufnr)

          if selection then
            checkout(selection[1], false)
          elseif prompt and prompt ~= "" then
            -- No match found — create new branch
            vim.ui.select({ "Yes", "No" }, {
              prompt = 'Create new branch "' .. prompt .. '"?',
            }, function(choice)
              if choice == "Yes" then
                checkout(prompt, true)
              end
            end)
          end
        end)

        return true
      end,
    })
    :find()
end

vim.keymap.set("n", "<leader>gco", open_branch_picker, { desc = "Git checkout (branch picker)" })
