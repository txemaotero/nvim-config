-- <leader>w*: window splits/focus/move
local wk = require("which-key")

wk.add({
    { "<leader>w",  group = "window" },
    { "<leader>w=", "<C-w>=",       desc = "Restore" },
    { "<leader>wF", "<C-w>_",       desc = "Focus hsplit" },
    { "<leader>wf", "<C-w>|",       desc = "Focus vsplit" },
    { "<leader>wS", "<C-w>s<C-w>j", desc = "HSplit & focus" },
    { "<leader>wV", "<C-w>v<C-w>l", desc = "VSplit & focus" },
    { "<leader>wh", "<C-w>h",       desc = "Move h" },
    { "<leader>wj", "<C-w>j",       desc = "Move j" },
    { "<leader>wk", "<C-w>k",       desc = "Move k" },
    { "<leader>wl", "<C-w>l",       desc = "Move l" },
    { "<leader>wo", "<C-w>o",       desc = "Keep current" },
    { "<leader>wq", "<C-w>q",       desc = "Quit current" },
    { "<leader>ws", "<C-w>s",       desc = "HSplit hor" },
    { "<leader>wt", "<C-w>T",       desc = "Move to tab" },
    { "<leader>wv", "<C-w>v",       desc = "VSplit vert" },
    { "<leader>ww", "<C-w>w",       desc = "Move to last" },
})
