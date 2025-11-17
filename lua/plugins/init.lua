return {
    ---- Must be pluggins--------
    "ralismark/opsort.vim", -- Allows sorting by values of lines
    "junegunn/vim-easy-align", -- Align text with ga
    { "kylechui/nvim-surround", config = true }, -- Change surround cs
    { "numToStr/Comment.nvim", config = true }, -- Comments
    "tpope/vim-repeat", -- Better repeat
    "tpope/vim-abolish", -- Better substitutions: Subvert
    { "windwp/nvim-autopairs", config = true }, -- Autoclose parenthesis
    "airblade/vim-rooter", -- Change the working directory when new file is open
    { "gbprod/yanky.nvim", config = true },

    -- Databases
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",

    --- More text objects
    {
        "chrisgrieser/nvim-various-textobjs",
        config = function()
            require("various-textobjs").setup({
                keympas = {
                    useDefautls = true,
                    disabledDefaults ={ "gw", "gc" },
                }
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },

    -- c++ utils
    {
        -- Define implementation from header
        "Badhi/nvim-treesitter-cpp-tools",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
    },

    ----------------- Appearence --------------------
    -- Nice error, warnings and notes list with SPC-i
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
    },

    "ryanoasis/vim-devicons", -- Icons
    "stevearc/dressing.nvim", -- Fancy input boxes
    -- See #AAAAAA colors
    {
        "uga-rosa/ccc.nvim",
        config = function()
            require("ccc").setup({
                highlighter = {
                    auto_enable = true,
                },
            })
        end,
    },

    ----------- Markdown preview ------------
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        name = 'render-markdown',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('render-markdown').setup({})
        end,
    },
    {
        'dhruvasagar/vim-table-mode'
    },

    -- Better qf
    {
        "kevinhwang91/nvim-bqf",
        config = true,
        ft = { "qf" },
    },

    {
        "github/copilot.vim",
        enabled = false,
        config = function()
            vim.g.copilot_filetypes = {
                markdown = false,
                norg = false,
            }
        end

    }
}
