local has_local_config, local_config = pcall(require, "neorg_local_config")
local workspaces = {}
if has_local_config then
   workspaces = local_config
end

return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope",
    },
    config = function()
        require('neorg').setup {
            load = {
                ["core.highlights"] = {
                    config = {
                        highlights = {
                            markup = {
                                bold = "+@markup.strong",
                                italic = "+@markup.italic"
                            }
                        }
                    }
                },
                ["core.defaults"] = {},
                ["core.export"] = {},
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
