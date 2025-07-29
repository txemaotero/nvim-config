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
                ["gsn"] = {function() require("oil").set_sort({{"name", "asc"}}) end, mode = "n"},
                ["gsN"] = {function() require("oil").set_sort({{"name", "desc"}}) end, mode = "n"},
                -- Size
                ["gss"] = {function() require("oil").set_sort({{"size", "asc"}}) end, mode = "n"},
                ["gsS"] = {function() require("oil").set_sort({{"size", "desc"}}) end, mode = "n"},
                -- Default
                ["gsd"] = {function() require("oil").set_sort({{"type", "asc"}, {"name", "asc"}}) end, mode = "n"},
                ["gsD"] = {function() require("oil").set_sort({{"type", "desc"}, {"name", "desc"}}) end, mode = "n"},
                -- Time (mod)
                ["gst"] = {function() require("oil").set_sort({{"mtime", "asc"}}) end, mode = "n"},
                ["gsT"] = {function() require("oil").set_sort({{"mtime", "desc"}}) end, mode = "n"},
            }
        })
    end,
}

