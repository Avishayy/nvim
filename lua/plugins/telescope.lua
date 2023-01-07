return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>" }
    },
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
        require("telescope").setup({
            defaults = {
                sorting_strategy = 'ascending',
                layout_config = {
                    prompt_position = 'top'
                }
            }
        })
    end
  },
}
