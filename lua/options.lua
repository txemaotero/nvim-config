-- Leader to space
vim.g.mapleader = " "
vim.g.python3_host_prog = "/usr/local/bin/python3"
-- vim.opt.clipboard = "unnamedplus"
vim.opt.pumblend = 0

-- load config file per project
vim.o.exrc = true

vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12"

-- Mouse control
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup"

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     pattern = "*",
--     callback = function()
--         vim.opt.relativenumber = false
--     end,
-- })
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     pattern = "*",
--     callback = function()
--         vim.opt.relativenumber = true
--     end,
-- })

-- Term colors
vim.opt.termguicolors = true

-- Undo persist
vim.opt.undofile = true
if vim.fn.has('win32') == 1 then
    vim.opt.undodir = os.getenv("UserProfile") .. "/.nvim/undodir"
else
    vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
end

-- Spell and text related
vim.opt.spelllang = {"en", "es", "gl"}
vim.opt.spellsuggest = {"best", 9}
vim.opt.spell = true
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"text", "tex", "markdown", "vimwiki", "norg"},
    callback = function()
        vim.opt_local.tw = 80
        vim.opt_local.conceallevel = 2
        vim.cmd[[hi! SpellBad guifg=#9c3838]]
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "cpp"},
    callback = function()
        vim.opt_local.tw = 120
    end,
})

-- Highlight current line
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.linebreak = true

-- Lines to end of window
vim.opt.scrolloff = 10

-- Indentation
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.list = true
vim.opt.listchars = "tab:-->,trail:·"

-- Best search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit"

-- Ripgrep if available
if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg = "rg --vimgrep"
end

-- Disable netrw to use Oil
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
