-- Per-FileType options and buffer-local mappings.
local wk = require("which-key")

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "tex", "markdown", "vimwiki", "norg" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.tw = 80
        vim.opt_local.conceallevel = 2
        vim.cmd([[hi! SpellBad guifg=#9c3838]])
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        wk.add({
            { "<CR>", "<C-]>",                desc = "Follow link",  buffer = 0 },
            { "<BS>", "<C-T>",                desc = "Go back",      buffer = 0 },
            { "o",    "/'\\l\\{2,\\}'<CR>",   desc = "Next option",  buffer = 0 },
            { "O",    "?'\\l\\{2,\\}'<CR>",   desc = "Prev. option", buffer = 0 },
            { "s",    "/|.\\{-}|<CR>",        desc = "Next subject", buffer = 0 },
            { "S",    "?|.\\{-}|<CR>",        desc = "Prev. subject", buffer = 0 },
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    callback = function()
        wk.add({
            { "<leader>ks", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file" },
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "norg",
    callback = function()
        wk.add({
            { "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", desc = "Jump", buffer = 0 },
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        wk.add({
            { "j", "gj", buffer = 0 },
            { "k", "gk", buffer = 0 },
        })
    end,
})
