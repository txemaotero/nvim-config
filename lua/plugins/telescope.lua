return {
    'nvim-telescope/telescope.nvim',
    build = ':TSUpdate',
    dependencies = {
        'ElPiloto/telescope-vimwiki.nvim',
        'nvim-lua/popup.nvim',
        'ThePrimeagen/git-worktree.nvim',
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },
    config = function()
        require("telescope").load_extension("git_worktree")
        require("telescope").load_extension("yank_history")
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                path_display={"truncate"},
                dynamic_preview_title=true,
            },
            extensions = {
                fzf = {}
            },
            pickers = {
                buffers = {
                    mappings = {
                        n = {
                            ["d"] = actions.delete_buffer,
                        }
                    }
                }
            },
        })
        require("telescope").load_extension("fzf")
    end
}
