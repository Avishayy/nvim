return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup {
        contrast = "hard",
        overrides = {
          -- Darker background for floating windows
          NormalFloat = { bg = "#282828" },
          -- Sign column to look like regular background
          SignColumn = { bg = "#1d2021" },
          -- Diff without reverse
          DiffAdd = { reverse = false, fg = "#b8bb26", bg = "#3c3836", },
          DiffDelete = { reverse = false, fg = "#fb4934", bg = "#3c3836", },
          DiffChange = { reverse = false, fg = "#7c6f64", bg = "#3c3836", },
          DiffText = { reverse = false, fg = "#8ec07c", bg = "#3c3836", },
        }
      }
      vim.cmd [[ colorscheme gruvbox ]]
    end,
  },
}
