-- <leader>b*: buffer pickers and basic buffer commands
local wk = require("which-key")

wk.add({
    { "<leader>b",  group = "Buffer" },
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Telescope find" },
    { "<leader>bd", "<cmd>bd<cr>",                desc = "Delete" },
    { "<leader>bD", "<cmd>bd!<cr>",               desc = "Delete (force)" },
    { "<leader>bn", "<cmd>bn<cr>",                desc = "Next" },
    { "<leader>bp", "<cmd>bp<cr>",                desc = "Previous" },
})
