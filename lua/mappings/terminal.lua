-- F1-F3 and <leader>T*: snacks.terminal as a VSCode-like bottom split.
local wk = require("which-key")

-- Bottom split spanning full width, 33% height. Shared across all openings
-- (snacks.terminal reuses a terminal with the same cwd + shell + opts).
local term_opts = {
    win = {
        position = "bottom",
        height = 0.33,
        width = 0,        -- full width (0 means "max")
        border = "none",
    },
}

local function toggle()
    Snacks.terminal.toggle(nil, term_opts)
end

local function open_new()
    -- `Snacks.terminal.open` always spawns a new terminal (no reuse).
    Snacks.terminal.open(nil, term_opts)
end

local function close_active()
    local opts = vim.tbl_extend("force", term_opts, { create = false })
    local term = Snacks.terminal.get(nil, opts)
    if term then
        term:close()
    end
end

wk.add({
    { "<F1>", toggle,      desc = "Terminal toggle" },
    { "<F2>", open_new,    desc = "Terminal new" },
    { "<F3>", close_active, desc = "Terminal close" },

    { "<leader>T",  group = "terminal" },
    { "<leader>Tt", open_new, desc = "terminal (new)" },
    { "<leader>TT", toggle,   desc = "toggle" },
})
