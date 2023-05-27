return {
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "Wansmer/treesj",
    event = "BufReadPost",
    opts = { max_join_length = 150 },
  },
  {
    "tpope/vim-eunuch",
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    keys = {
      "ys",
      "ds",
      "cs",
    },
    config = true,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        log_level = "error",
      }
    end,
  },
  {
    "tpope/vim-abolish",
    event = "VeryLazy",
  },
  {
    "dhruvasagar/vim-zoom",
    keys = {
      { "<leader>z", "<Plug>(zoom-toggle)" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = true,
  },
  {
    "lfv89/vim-interestingwords",
    keys = { "<leader>k", "<leader>K" },
  },
  {
    "mcookly/rosetta.nvim",
    lazy = false,
    config = function()
      require("rosetta").setup {
        lang = {
          hebrew = { -- Keyboard commands are created for each language automatically if `user_commands` are enabled.
            keymap = "hebrew_utf-8",
            rtl = true,
            unicode_range = { "0590-05FF" },
            options = { -- `vim.o` options can be passed through here.
              delcombine = true,
            }
          }
        }
      }
    end,
  },
}
