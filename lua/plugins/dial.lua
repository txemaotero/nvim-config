return {
    'monaqa/dial.nvim',
    config = function ()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group{
            -- default augends used when no group name is specified
            default = {
                augend.integer.alias.decimal,   -- nonnegative decimal number (0, 1, 2, 3, ...)
                augend.integer.alias.hex,       -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                augend.constant.alias.bool,    -- boolean value (true <-> false)
                augend.constant.new{
                    elements = {"TRUE", "FALSE"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new{
                    elements = {"True", "False"},
                    word = true,
                    cyclic = true,
                },
                augend.constant.new{
                    elements = {"ON", "OFF"},
                    word = true,
                    cyclic = true,
                },
                augend.date.alias["%d/%m/%Y"],
                augend.date.new{
                    pattern = "%d-%m-%Y",
                    default_kind = "day",
                    -- if true, it does not match dates which does not exist, such as 2022/05/32
                    only_valid = true,
                    -- if true, it only matches dates with word boundary
                    word = false,
                },
                augend.constant.new{
                    elements = {"and", "or"},
                    word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                    cyclic = true,  -- "or" is incremented into "and".
                },
                augend.constant.new{
                    elements = {"&&", "||"},
                    word = false,
                    cyclic = true,
                },
            },
        }

        vim.keymap.set("n", "<C-a>", function()
            require("dial.map").manipulate("increment", "normal")
        end)
        vim.keymap.set("n", "<C-x>", function()
            require("dial.map").manipulate("decrement", "normal")
        end)
        vim.keymap.set("n", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gnormal")
        end)
        vim.keymap.set("n", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gnormal")
        end)
        vim.keymap.set("v", "<C-a>", function()
            require("dial.map").manipulate("increment", "visual")
        end)
        vim.keymap.set("v", "<C-x>", function()
            require("dial.map").manipulate("decrement", "visual")
        end)
        vim.keymap.set("v", "g<C-a>", function()
            require("dial.map").manipulate("increment", "gvisual")
        end)
        vim.keymap.set("v", "g<C-x>", function()
            require("dial.map").manipulate("decrement", "gvisual")
        end)
    end
}
