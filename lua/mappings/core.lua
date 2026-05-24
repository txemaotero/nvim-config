-- Root-level keymaps and shared helpers: window jumps, basic motions,
-- alternate buffer, no-highlight, terminal escape, wrap toggle.
local wk = require("which-key")

local function open_explorer()
    if vim.bo.buftype == "terminal" then
        vim.cmd("edit " .. vim.fn.fnameescape(vim.fn.getcwd()))
    else
        vim.cmd("edit %:p:h")
    end
end

local function toggle_quickfix()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win["quickfix"] == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end

local function reload_plugin(plugin_name)
    for name, _ in pairs(package.loaded) do
        if name:match("^" .. plugin_name) then
            package.loaded[name] = nil
        end
    end
    require(plugin_name).setup()
end

-- Suspend disabled (we use tmux/wezterm session management instead).
vim.keymap.set({ "n", "x" }, "<C-Z>", "<Nop>")

wk.add({
    { "<leader>R",     function() reload_plugin("neogit") end, desc = "Reload neogit" },
    { "<leader>.",     "<cmd>e $MYVIMRC<cr>",                  desc = "Open config" },
    { "<leader>;",     "<cmd>Telescope commands<cr>",          desc = "Commands" },
    { "<leader><Tab>", "<cmd>b#<cr>",                          desc = "Alternate buffer" },
    { "<leader>N",     "<cmd>let @/ = ''<cr>",                 desc = "No highlight" },
    { "<leader>O",     "<cmd>tabe<cr>",                        desc = "Open New Tab" },
    { "<leader>e",     "<cmd>edit %:p:h<cr>",                  desc = "Explorer" },
    { "<leader>q",     toggle_quickfix,                        desc = "Toggle Quickfix" },
    { "<leader>W",     function() vim.o.wrap = not vim.o.wrap end, desc = "Toggle wrap" },
    { "-",             open_explorer,                          desc = "Explorer" },

    -- Window-pane navigation and convenience motions
    { "<C-h>",   "<C-w>h",            desc = "Window h" },
    { "<C-j>",   "<C-w>j",            desc = "Window j" },
    { "<C-k>",   "<C-w>k",            desc = "Window k" },
    { "<C-l>",   "<C-w>l",            desc = "Window l" },
    { "<CR>",    "o<Esc>",            desc = "New line" },
    { "<S-Tab>", "<cmd>tabnext<cr>",  desc = "Next tab" },
    { "D",       "d$",                desc = "Delete until end" },
    { "J",       "mzJ`z",             desc = "Join lines" },
    { "Y",       "y$",                desc = "Yank until end" },
    { "gp",      "`[v`]",             desc = "Select pasted" },
    { "ga",      "<Plug>(EasyAlign)", desc = "EasyAlign",       mode = { "n", "x" } },

    -- Terminal-mode escape
    { "<Esc><Esc>", "<C-\\><C-n>", desc = "Esc", mode = "t" },

    -- Move visual selection up/down
    { "<C-j>", ":m '>+1<CR>gv=gv", desc = "Move down", mode = "v" },
    { "<C-k>", ":m '<-2<CR>gv=gv", desc = "Move up",   mode = "v" },
})
