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
            "ibhagwan/fzf-lua",              -- optional
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
    -- Easy managements of worktrees (remember to clone with --bare)
    {
        'ThePrimeagen/git-worktree.nvim',
        config = function()
            local Worktree = require("git-worktree")
            local Job = require("plenary.job")
            Worktree.on_tree_change(function(op, metadata)
                if op == Worktree.Operations.Create then
                    -- TODO: Check, this does not work
                    Job:new({
                        command = "git",
                        args = { "submodule", "update", "--init", "--recursive" }
                    }):sync()
                    require("notify")("Bien")
                end
            end)
        end
    }
}
