return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 2000,
    config = function()
        require("tokyonight").setup({})
        vim.cmd("colorscheme tokyonight-night")
    end,
}
