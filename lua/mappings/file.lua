-- <leader>f*: file pickers and save
local wk = require("which-key")

wk.add({
    { "<leader>f",  group = "File" },
    { "<leader>fS", "<cmd>wall<cr>",                  desc = "Save all" },
    { "<leader>fa", function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
    end,                                              desc = "Find All Files" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find File" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent Files" },
    { "<leader>fs", "<cmd>w<cr>",                     desc = "Save" },
})
