return {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        'xiyaowong/nvim-transparent',
        'nvim-telescope/telescope.nvim',
        "nvim-neorg/neorg-telescope",
        "nvim-treesitter/nvim-treesitter",
    },
    build = ":Neorg sync-parsers",
    config = function()
        require('neorg').setup {
            load = {
                ["core.defaults"] = {},
                ["core.integrations.telescope"] = {},
                ["core.norg.concealer"] = {
                    config = {
                        folds = false,
                    }
                },
                ["core.norg.completion"] = {
                    config = {
                        engine = "nvim-cmp"
                    },
                },
                ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            work = "C:\\Users\\josote3651\\OneDrive - CTAG\\Documentos\\notas",
                        }
                    }
                },
            }
        }
    end
}
