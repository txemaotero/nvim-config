----------------- Git ------------------------------------
return {
    -- Git commands
    'tpope/vim-fugitive',

    {
        "txemaotero/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        opts = {
            commit_view = {
                invert_open_file = false,
            },
        }
    },

    -- Git diff simbols on number column
    {
        'lewis6991/gitsigns.nvim',
        config = true,
    },
}
