return {
    ---- Must be pluggins--------
    "ralismark/opsort.vim", -- Allows sorting by values of lines
    "junegunn/vim-easy-align", -- Align text with ga
    { "kylechui/nvim-surround", config = true }, -- Change surround cs
    { "numToStr/Comment.nvim", config = true }, -- Comments
    "tpope/vim-repeat", -- Better repeat
    "tpope/vim-abolish", -- Better substitutions: Subvert
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",

    { "windwp/nvim-autopairs", config = true }, -- Autoclose parenthesis
    "vim-scripts/ReplaceWithRegister", -- Replace with register
    "airblade/vim-rooter", -- Change the working directory when new file is open
    { "gbprod/yanky.nvim", config = true },

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
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            local signs = {
                Error = "",
                Warn = "",
                Hint = "",
                Info = "",
                Ok = "",

            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
            require("trouble").setup({
                icons = true,
                signs = {
                    error = signs.Error,
                    warning = signs.Warn,
                    hint = signs.Hint,
                    information = signs.Info,
                    other = signs.Ok,
                },
            })
        end,
    },
    "ryanoasis/vim-devicons", -- Icons
    "stevearc/dressing.nvim", -- Fancy input boxes
    {
        "uga-rosa/ccc.nvim",
        config = function()
            require("ccc").setup({
                highlighter = {
                    auto_enable = true,
                },
            })
        end,
    }, -- See colors hex

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
        name = 'render-markdown',                                                            -- Only needed if you have another plugin named markdown.nvim
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        config = function()
            require('render-markdown').setup({})
        end,
    },

    -------------- Jupyter ascending -----------
    -- Jupyter form nvim. Needs additional installation:
    -- $ pip install jupyter_ascending
    -- $ jupyter nbextension install --py --sys-prefix jupyter_ascending
    -- $ jupyter nbextension     enable jupyter_ascending --sys-prefix --py
    -- $ jupyter serverextension enable jupyter_ascending --sys-prefix --py
    -- And remember to crate the pairs before edditing
    -- $ python -m jupyter_ascending.scripts.make_pair --base example
    {
        "untitled-ai/jupyter_ascending.vim",
        cmd = { "JupyterExecute", "JupyterExecuteAll" },
    },

    -- Better qf
    {
        "kevinhwang91/nvim-bqf",
        config = true,
        ft = { "qf" },
    },

    -- Lua
    {
        "folke/zen-mode.nvim",
        opts = { }
    },
}
