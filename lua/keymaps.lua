local map = vim.keymap.set

vim.api.nvim_create_user_command("NvimRestart",
  function()
    require("utils").reload_config()
  end,
  { nargs = "*" }
)

map("", "<leader>R", "<Esc>:NvimRestart<CR>",
  { silent = true, desc = "reload nvim configuration" })

vim.g.mapleader = "\\"
