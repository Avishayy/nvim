return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup {
        sections = {
          lualine_c = {
            {
              "filename",
              path = 1, -- Relative path
            },
          },
        },
        options = {
          theme = "catppuccin",
        },
        extensions = {
          "fugitive",
          "fzf",
          "quickfix",
        },
      }
    end,
  },
}
