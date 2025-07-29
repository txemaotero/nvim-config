return {
    'nvim-telescope/telescope.nvim',
    build = ':TSUpdate',
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        {
            dir = os.getenv("HOME") .. "/repos/telescope-cppman.nvim",
            config = function ()
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = {"cpp"},
                    callback = function ()
                        vim.schedule(
                            function ()
                                vim.keymap.set("n", "<leader>C", require("cppman").telescope_cppman, {buffer = true})
                            end
                        )
                    end
                })
            end
        }
    },
    config = function()
        require("telescope").load_extension("yank_history")
        require("telescope").load_extension("cppman")
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
