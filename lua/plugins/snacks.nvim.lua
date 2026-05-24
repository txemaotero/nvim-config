-- snacks.nvim: utility collection; active modules: bigfile, input, notifier (vim.notify), quickfile, statuscolumn, terminal, zen
-- keywords: utility, qol, bigfile, notify, terminal, zen, statuscolumn, ui
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        image = { enabled = false },
        input = { enabled = true },
        notifier = { enabled = true, timeout = 3000 },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enabled = true },
        zen = {
            enabled = true,
            toggles = {
                dim = false
            }
        },
    },
}
