return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "folke/noice.nvim",
    },
    config = function()
      require("lualine").setup {
        sections = {
          lualine_c = {
            {
              "filename",
              path = 1, -- Relative path
            },
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
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
