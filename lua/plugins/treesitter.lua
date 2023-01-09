return {
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = function()
      require("treesitter-context").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "cpp",
          "css",
          "diff",
          "gitignore",
          "go",
          "graphql",
          "help",
          "html",
          "http",
          "java",
          "javascript",
          "jsdoc",
          "jsonc",
          "latex",
          "lua",
          "markdown",
          "markdown_inline",
          "php",
          "python",
          "query",
          "regex",
          "rust",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
          "json",
        },
        sync_install = true,
        auto_install = false,
        highlight = { enable = true },
        additional_vim_regex_highlighting = false,
        indent = { enable = false },
        context_commentstring = { enable = true, enable_autocmd = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-bs>",
          },
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>n"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>p"] = "@parameter.inner",
            },
          },
        },
        matchup = {
          enable = true,
        },
      })
    end,
  },
}
