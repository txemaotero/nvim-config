-- <leader>l*: LSP commands. Most concrete actions are bound in the
-- LspAttach autocmd (lua/plugins/nvim-lspconfig.lua) on a per-buffer
-- basis; this file only declares the which-key group + descriptions and
-- the buffer-format mapping which is filetype-agnostic.
local wk = require("which-key")

wk.add({
    { "<leader>l",   group = "LSP" },
    { "<leader>l=",  desc = "Format range" },
    { "<leader>lD",  desc = "Diagnostics" },
    { "<leader>la",  desc = "Action" },
    { "<leader>lf",  "<cmd>Format<cr>",     desc = "Format file" },
    { "<leader>lr",  desc = "Rename" },
    { "<leader>ld",  group = "Document" },
    { "<leader>ldc", desc = "Class" },
    { "<leader>ldf", desc = "Function" },
})
