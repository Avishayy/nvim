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
        }
      }
      vim.cmd [[ colorscheme gruvbox ]]
    end,
  },
}
