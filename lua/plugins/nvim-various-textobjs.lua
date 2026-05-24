-- nvim-various-textobjs: extra text objects (indentation, subword, value, key, URL, number, etc.)
-- keywords: text-objects, motion, edit, indent, subword, value
return {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
        require("various-textobjs").setup({
            keymaps = {
                useDefaults = true,
                disabledDefaults = { "gw", "gc" },
            },
        })
    end,
}
