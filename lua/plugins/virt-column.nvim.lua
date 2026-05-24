-- virt-column.nvim: virtual vertical rulers at columns 80 and 120
-- keywords: column, ruler, line, vertical, colorcolumn, textwidth, ui
return {
    "lukas-reineke/virt-column.nvim",
    config = function ()
        require("virt-column").setup { char = "│", virtcolumn = "80,120" }
        vim.cmd[[highlight VirtColumn guifg=#444444]]
    end
}

