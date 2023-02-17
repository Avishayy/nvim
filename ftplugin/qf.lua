local function map_cr()
  -- Close after seelction in :Man pages
  if vim.w.quickfix_title == "Man TOC" then
    return "<cr>:lclo<cr>"
  end
  return "<cr>"
end

vim.keymap.set("n", "<cr>", map_cr(), { buffer = true })
