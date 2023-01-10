return {
  {
    "jayp0521/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    lazy = false,
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python",
        }
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
}
