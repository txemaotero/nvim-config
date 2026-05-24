-- <leader>T*: snacks.terminal (replaced vim-floaterm in the 0.12 cleanup).
local wk = require("which-key")

wk.add({
    { "<leader>T",  group = "terminal" },
    { "<leader>Tt", function() Snacks.terminal() end,        desc = "terminal" },
    { "<leader>TT", function() Snacks.terminal.toggle() end, desc = "toggle" },
})
