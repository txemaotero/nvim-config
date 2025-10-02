return {
    'stevearc/oil.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('oil').setup({
            view_options = {
                show_hidden = true,
            },
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
            keymaps = {
                -- Helpers for sorting
                ["gs"] = false,
                -- Ask
                ["gsa"] = {"actions.change_sort", mode = "n"},
                -- Name
                ["gsn"] = {function() require("oil").set_sort({{"name", "asc"}}) end, mode = "n", desc = "Sort name asc"},
                ["gsN"] = {function() require("oil").set_sort({{"name", "desc"}}) end, mode = "n", desc = "Sort name desc"},
                -- Size
                ["gss"] = {function() require("oil").set_sort({{"size", "asc"}}) end, mode = "n", desc = "Sort size asc"},
                ["gsS"] = {function() require("oil").set_sort({{"size", "desc"}}) end, mode = "n", desc = "Sort size desc"},
                -- Default
                ["gsd"] = {function() require("oil").set_sort({{"type", "asc"}, {"name", "asc"}}) end, mode = "n", desc = "Sort type asc"},
                ["gsD"] = {function() require("oil").set_sort({{"type", "desc"}, {"name", "desc"}}) end, mode = "n", desc = "Sort type desc"},
                -- Time (mod)
                ["gst"] = {function() require("oil").set_sort({{"mtime", "asc"}}) end, mode = "n", desc = "Sort mod time asc"},
                ["gsT"] = {function() require("oil").set_sort({{"mtime", "desc"}}) end, mode = "n", desc = "Sort mod time desc"},
                -- Overlapping with window
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-t>"] = false,
                ["<C-l>"] = false,
                ["gr"] = "actions.refresh",
            }
        })
    end,
}

