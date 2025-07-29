--------------- Key maps--------------------------------
return {
    'folke/which-key.nvim',
    config = function()
        -- Setup options
        require("which-key").setup({
            preset = "modern",
            plugins = {
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                presets = {
                    operators = false,
                    motions = true, -- adds help for motions
                    text_objects = false,
                    windows = false, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                },
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "center", -- align columns left, center or right
            },
        })
    end
}

