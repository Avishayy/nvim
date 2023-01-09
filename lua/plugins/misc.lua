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
    config = { max_join_length = 150 },
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
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      require('auto-session').setup {
        log_level = 'error',
      }
    end
  },
}
