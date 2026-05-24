-- <leader>g*: git interfaces (neogit + gitsigns blame).
local wk = require("which-key")

wk.add({
    { "<leader>g",  group = "Git" },
    { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle blame all" },
    { "<leader>gb", "<cmd>Gitsigns blame_line<cr>",                desc = "Blame line" },
    { "<leader>gg", "<cmd>Neogit<cr>",                             desc = "Git" },
})
