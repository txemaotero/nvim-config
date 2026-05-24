-- transparent.nvim: make many UI backgrounds transparent (only when not in GUI)
-- keywords: transparent, background, alpha, ui
return {
    'xiyaowong/transparent.nvim',
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

                "Pmenu",
                "PmenuThumb",
                "CmpPmenuBorder",
                "WildMenu",
                "CmpDocumentation",
                "CmpDocumentationBorder",

                "WhichKeyNormal",
                "WhichKeyTitle",
                "LspFloatWinNormal",

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
                "FloatShadowThrough",
        })
        vim.g.transparent_enabled = true
    end,
}
