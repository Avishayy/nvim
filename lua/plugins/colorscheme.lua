return {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.gruvbox_contrast_dark = "hard"
        -- Will set sign column to look like the line number
        vim.g.gruvbox_sign_column = "bg0"
        vim.cmd [[ colorscheme gruvbox ]]
    end,
}
