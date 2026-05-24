-- <leader>i*: diagnostics / quickfix / loclist / references via Trouble.
local wk = require("which-key")

wk.add({
    { "<leader>i",  group = "Info" },
    { "<leader>iD", "<cmd>Trouble diagnostics toggle<cr>",                            desc = "Project diagnostics" },
    { "<leader>id", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",               desc = "Buffer diagnostics" },
    { "<leader>ii", "<cmd>Trouble<cr>",                                               desc = "Trouble" },
    { "<leader>il", "<cmd>Trouble loclist toggle<cr>",                                desc = "Loclist" },
    { "<leader>iq", "<cmd>Trouble qflist toggle<cr>",                                 desc = "Quickfix" },
    { "<leader>ir", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",     desc = "Symbol references" },
    { "<leader>iv", function()
        local current = vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = not current, virtual_text = current })
    end,                                                                              desc = "Toggle virtual_lines" },
})
