return {
  "L3MON4D3/LuaSnip",
  config = function()
    local luasnip = require("luasnip")
    local map = vim.keymap.set

    map({ "i", "s" }, "<C-j>", function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        if fallback then
          fallback()
        end
      end
    end)

    map({ "i", "s" }, "<C-k>", function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        if fallback then
          fallback()
        end
      end
    end)

    map({ "i", "s" }, "<C-l>", function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        if fallback then
          fallback()
        end
      end
    end)
  end
}
