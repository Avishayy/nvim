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
            },
          },
        },
      }
    end,
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          }, -- Adds pretty icons to your documents
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                work = "~/notes",
                personal = "~/personal_notes",
              },
            },
          },
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                -- I want my regualar <CR> saves mapping, use K instead
                keybinds.remap_key("norg", "n", "<CR>", "K")

                -- Can't use <C-Space> on my mac as I use it for language switch, CTRL-T is fine
                keybinds.remap_key("norg", "n", "<C-Space>", "<C-t>")
              end,
            },
          },
          -- Convert unordered lists to ordered lists or vice versa with <LL>LT
          ["core.pivot"] = {},
          -- Continue current type of item (heading, list, todo) with Alt-Enter
          ["core.itero"] = {},
          -- Support completion in norg files
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
        },
      }
    end,
  },
}
