-- ccc.nvim: highlight color codes (#AAAAAA, rgb(), hsl()) inline; color picker
-- keywords: color, highlight, css, picker, hex, rgb, hsl
return {
    "uga-rosa/ccc.nvim",
    config = function()
        require("ccc").setup({
            highlighter = { auto_enable = true },
        })
    end,
}
