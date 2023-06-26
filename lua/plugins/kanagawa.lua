return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 2000,
    config = function()
        require("tokyonight").setup({
        })
        vim.cmd("colorscheme tokyonight-night")
        vim.cmd("hi @text.todo guifg=#fa3939")
    end
}
