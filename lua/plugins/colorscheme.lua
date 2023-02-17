return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        integrations = {
          mason = true,
          noice = true,
          cmp = true,
          notify = true,
          treesitter = true,
          dap = true,
          lsp_trouble = true,
        },
      }
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
