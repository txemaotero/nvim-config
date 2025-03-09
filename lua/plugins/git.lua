----------------- Git ------------------------------------
return {
    -- Git commands
    'tpope/vim-fugitive',
    -- Git commit browser (:GV)
    'junegunn/gv.vim',

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    },

    -- Git diff simbols on number column
    {
        'lewis6991/gitsigns.nvim',
        config = true,
    },
    -- Shows git commits under the cursor (leader gm)
    {
        'rhysd/git-messenger.vim',
        lazy = true,
    },
}
