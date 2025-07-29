return {
    'xiyaowong/transparent.nvim',
    dependencies = {
        'akinsho/bufferline.nvim',
        'stevearc/dressing.nvim',
    },
    lazy = false,
    priority = 1000,
    enabled = function()
        -- Disable if is gui
        return vim.fn.has('gui_running') == 0
    end,
    config = function()
        require("transparent").setup({})
        vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, {
                "TelescopeNormal",
                "TelescopeBorder",
                "TelescopePromptBorder",
                "TelescopePromptTitle",

                "NvimTreeNormal",
                "GvimTreeNormalNC",
                "NvimTreeWinSeparator",

                "Pmenu",
                "PmenuThumb",
                "CmpPmenuBorder",
                "WildMenu",
                "CmpDocumentation",
                "CmpDocumentationBorder",

                "WhichKeyNormal",
                "WhichKeyTitle",
                "LspFloatWinNormal",

                "BufferLineTabClose",
                "BufferlineBufferSelected",
                "BufferLineFill",
                "BufferLineBackground",
                "BufferLineSeparator",
                "BufferLineIndicatorSelected",

                "NotifyINFOBody",
                "NotifyINFOBody14",
                "NotifyWARNBody",
                "NotifyERRORBody",
                "NotifyDEBUGBody",
                "NotifyTRACEBody",

                "NotifyINFOBorder",
                "NotifyWARNBorder",
                "NotifyERRORBorder",
                "NotifyDEBUGBorder",
                "NotifyTRACEBorder",
                "NotifyTRACEBorder6",

                "DiagnosticVirtualTextError",
                "DiagnosticVirtualTextWarn",
                "DiagnosticVirtualTextInfo",
                "DiagnosticVirtualTextHint",

                "Normal",
                "NormalSB",
                "NormalNC",
                "NormalFloat",

                "FloatBorder",
                "FloatShadow",
                -- "FloatTitle",
                "FloatShadowThrough",

        })
        vim.g.transparent_enabled = true
    end,
}

