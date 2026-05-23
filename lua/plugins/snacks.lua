return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        image = { enabled = false },
        input = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        zen = {
            enabled = true,
            toggles = {
                dim = false
            }
        },
    },
}
