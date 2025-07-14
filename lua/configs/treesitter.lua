local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

ts.setup {
  highlight = {
    enable = true,
    disable = { "text" },
  },
  indent = {
    enable = true,
    disable = { "text" },
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "javascript",
    "json",
    "yaml",
    "swift",
    "css",
    "html",
    "lua",
    "c",
    "cpp",
    "c_sharp",
    "xml",
    "typescript",
    "styled",
    "diff",
    "proto",
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
parser_config.ejs = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "ejs",
}
