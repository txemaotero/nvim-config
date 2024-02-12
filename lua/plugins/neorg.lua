local has_local_config, local_config = pcall(require, "neorg_local_config")
local workspaces = {}
if has_local_config then
   workspaces = local_config
end

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
                ["core.concealer"] = {
                    config = {
                        folds = false,
                    }
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp"
                    },
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = workspaces,
                    }
                },
            }
        }
    end
}
