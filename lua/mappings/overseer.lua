-- <leader>o*: overseer task runner.
local wk = require("which-key")

wk.add({
    { "<leader>o",  group = "Overseer" },
    { "<leader>ol", "<cmd>OverseerRestartLast<cr>",   desc = "Restart last" },
    { "<leader>oo", "<cmd>OverseerRun<cr>",           desc = "Run task" },
    { "<leader>os", "<cmd>OverseerOpenLastOutput<cr>", desc = "Open last output" },
    { "<leader>ot", "<cmd>OverseerToggle<cr>",        desc = "Toggle" },
})
