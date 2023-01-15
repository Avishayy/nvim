-- TODO: fix the ugly style of the floating window
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'line',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

local indentation_augroup = vim.api.nvim_create_augroup("Indentation", {})
vim.api.nvim_create_autocmd("FileType", {
  group = indentation_augroup,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  command = "setlocal shiftwidth=2 tabstop=2"
})
