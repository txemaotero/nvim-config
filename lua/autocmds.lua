-- Per-FileType options and buffer-local mappings.
-- Note: buffer-local mappings here use vim.keymap.set with `buffer = args.buf`
-- rather than which-key's wk.add({...buffer=0}); wk.add re-registers on every
-- BufEnter so checkhealth flags it as duplicated.

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "tex", "markdown", "vimwiki", "norg" },
    callback = function()
        vim.opt_local.tw = 80
        vim.opt_local.conceallevel = 2
        vim.cmd([[hi! SpellBad guifg=#9c3838]])
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function(args)
        local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
        end
        map("<CR>", "<C-]>",                "Follow link")
        map("<BS>", "<C-T>",                "Go back")
        map("o",    "/'\\l\\{2,\\}'<CR>",   "Next option")
        map("O",    "?'\\l\\{2,\\}'<CR>",   "Prev. option")
        map("s",    "/|.\\{-}|<CR>",        "Next subject")
        map("S",    "?|.\\{-}|<CR>",        "Prev. subject")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    callback = function(args)
        vim.keymap.set("n", "<leader>ks", "<cmd>ClaudeCodeTreeAdd<cr>", {
            buffer = args.buf,
            desc = "Add file",
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "norg",
    callback = function(args)
        vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", {
            buffer = args.buf,
            desc = "Jump",
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function(args)
        vim.keymap.set("n", "j", "gj", { buffer = args.buf })
        vim.keymap.set("n", "k", "gk", { buffer = args.buf })
    end,
})
