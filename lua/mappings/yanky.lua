-- yanky.nvim integration: cycle through yank history with C-n/C-p after pasting,
-- and use Yanky's put/yank Plug mappings as defaults.
local wk = require("which-key")

local function go_middle()
    local line = vim.api.nvim_get_current_line()
    local middle_pos = math.floor(string.len(line) / 2)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_win_set_cursor(0, { curr_line, middle_pos })
end

wk.add({
    { "<C-n>", "<Plug>(YankyCycleForward)",  desc = "Yank Forward" },
    { "<C-p>", "<Plug>(YankyCycleBackward)", desc = "Yank Back" },
    {
        { "P",  "<Plug>(YankyPutBefore)",  desc = "Put before" },
        { "gm", go_middle,                 desc = "Go middle line" },
        { "p",  "<Plug>(YankyPutAfter)",   desc = "Put after" },
        { "y",  "<Plug>(YankyYank)",       desc = "Yank" },
        mode = { "n", "x" },
    },
})
