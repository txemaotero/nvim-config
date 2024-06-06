return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 2000,
        config = function()
            require("kanagawa").setup({
            })
        end
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 2000,
        config = function()
            require("tokyonight").setup({
            })
            vim.cmd("colorscheme tokyonight-night")
        end
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }

}
