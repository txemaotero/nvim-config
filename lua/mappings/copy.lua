-- Clipboard helpers (system register) and copy-relative-path commands.
local wk = require("which-key")

wk.add({
    { "<leader>p", '"_dP', desc = "Paste from clipboard", mode = "x" },
    { "<leader>D", '"_d',  desc = "Delete to clipboard",  mode = { "n", "v" } },
    { "<leader>y", '"+y',  desc = "Copy to clipboard",    mode = { "n", "v" } },

    { "<leader>c",  group = "Copy" },
    { "<leader>cp", require("utils/copy_rel_path").copy_relpath,           desc = "Copy relative path" },
    { "<leader>cP", require("utils/copy_rel_path").copy_relpath_with_line, desc = "Copy relative path with line" },
})
