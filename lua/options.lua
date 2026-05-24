-- Leader to space
vim.g.mapleader = " "
vim.g.python3_host_prog = os.getenv("HOME") .. "/.local/share/nvim/pyenv/bin/python"
vim.opt.pumblend = 0

-- load config file per project
vim.o.exrc = true

-- Mouse control
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup"

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Term colors
vim.opt.termguicolors = true

-- Undo persist
vim.opt.undofile = true
if vim.fn.has("win32") == 1 then
    vim.opt.undodir = os.getenv("UserProfile") .. "/.nvim/undodir"
else
    vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
end

-- Spell on everywhere; FileType autocmd in autocmds.lua tunes tw/conceallevel for prose
vim.opt.spell = true
vim.opt.spelllang = { "en", "es", "gl" }
vim.opt.spellsuggest = { "best", 9 }

vim.opt.cursorline = true
vim.opt.linebreak = true

-- Lines to window bottom
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
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable perl and node providers (no js/perl plugins in use)
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false, -- toggled via <leader>iv (see mappings.lua)
})
