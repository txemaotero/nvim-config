function TodoCheck ()

    vim.cmd[[hi Conceal guibg=NONE guifg=white]]

    vim.opt_local.cole = 1
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"text", "latex", "markdown", "vimwiki"},
    callback = TodoCheck
})
