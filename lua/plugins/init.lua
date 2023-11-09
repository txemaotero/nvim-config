return {
    ---- Must be pluggins--------
    "ralismark/opsort.vim", -- Allows sorting by values of lines
    "junegunn/vim-easy-align", -- Align text with ga
    { "kylechui/nvim-surround", config = true }, -- Change surround cs
    { "numToStr/Comment.nvim", config = true }, -- Comments
    "tpope/vim-repeat", -- Better repeat
    "tpope/vim-abolish", -- Better substitutions
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",

    { "windwp/nvim-autopairs", config = true }, -- Autoclose parenth
    "vim-scripts/ReplaceWithRegister", -- Replace with register
    { "phaazon/hop.nvim", branch = "v2", config = true }, -- Easy motion with SPC-h
    "airblade/vim-rooter", -- Change the working directory when new file is open
    { "gbprod/yanky.nvim", config = true },

    {
        "github/copilot.vim",
        config = function()
            vim.api.nvim_set_var("copilot_filetypes", {
                ["dap-repl"] = false,
            })
        end,
    },

    --- More text objects
    {
        "chrisgrieser/nvim-various-textobjs",
        config = function()
            require("various-textobjs").setup({
                useDefaultKeymaps = true,
                disabledKeymaps = { "gw" },
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
        "Badhi/nvim-treesitter-cpp-tools",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
    },

    -- Add colors to funciton agruments
    {
        "m-demare/hlargs.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    ----------------- Appearence --------------------
    -- Nice error, warnings and notes list with SPC-i
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            local signs = {
                Error = " ",
                Warn = " ",
                Hint = " ",
                Info = " ",
                Ok = "﫠",
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
    -- {'norcalli/nvim-colorizer.lua', config = true}, -- See colors hex
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
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
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

    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        event = "VeryLazy",
        opts = {
            handlers = {},
            ensure_indtalled = {
                "codelldb",
            },
        },
    },
    -- Better qf
    {
        "kevinhwang91/nvim-bqf",
        config = true,
        ft = { "qf" },
    },

    -- Zen
    {
        "Pocco81/true-zen.nvim",
        config = true,
    },
}
