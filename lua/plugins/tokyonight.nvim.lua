-- tokyonight.nvim: colorscheme (tokyonight-night variant is the active theme)
-- keywords: colorscheme, theme, color, ui
return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 2000,
    config = function()
        require("tokyonight").setup({})
        vim.cmd("colorscheme tokyonight-night")
    end,
}
