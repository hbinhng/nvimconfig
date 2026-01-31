return {
  {
    "f-person/git-blame.nvim",
    lazy = false,
    event = "BufReadPre",
    opts = {
      enabled = false, -- so <leader>gb toggles it
    },
  },

  {
    "DamianVCechov/hexview.nvim",
    lazy = false,
    config = function()
      require("hexview").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"

      opts.pickers = opts.pickers or {}
      opts.pickers.buffers = opts.pickers.buffers or {}
      opts.pickers.buffers.mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      }

      return opts
    end,
  },

  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  {
    "Ramilito/kubectl.nvim",
    config = function()
      require("kubectl").setup()
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    opts = {},
    ft = { "markdown" },
  },

  {
    "ziglang/zig.vim",
    ft = "zig",
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "MunifTanjim/prettier.nvim",
    config = function()
      require "configs.prettierd"
    end,
  },

  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "typescript-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "eslint-lsp",
        "gopls",
        "prettierd",
        "protols",
        "buf",
      },
    },
  },

  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-refactor",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          handlers = {
            ["jdtls"] = function()
              require("java").setup()
            end,
          },
        },
      },
    },
    opts = {},
  },

  --
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "c",
        "cpp",
        "c_sharp",
        "typescript",
        "javascript",
        "tsx",
        "php",
        "java",
        "python",
        "sql",
        "prisma",
        "make",
        "markdown",
        "markdown_inline",
        "latex",
        "json",
        "ini",
        "yaml",
        "gitignore",
        "go",
        "rust",
        "dot",
        "cmake",
        "bash",
        "awk",
        "xml",
      },
    },
    config = function()
      require "configs.treesitter"
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        keymap = {
          accept = "<C-'>",
          accept_word = "<C-;>",
          accept_line = "<C-.>",
          next = "<C-0>",
          prev = "<C-9>",
          dismiss = "<C-->",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  {
    "LintaoAmons/bookmarks.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
      { "nvim-telescope/telescope.nvim" },
      { "stevearc/dressing.nvim" }, -- optional: better UI
    },
    config = function()
      require("bookmarks").setup {}
    end,
    lazy = false,
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "redis" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
