return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "nvim-neotest/nvim-nio",
        "alfaix/neotest-gtest",
        "antoinemadec/FixCursorHold.nvim"
    },
    config = function()
        require("neotest-gtest").setup({
            debug_adapter = "cppdbg",
            mappings = { configure = "C" },
        })
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                    python = "env/bin/python",
                }),
                require("neotest-gtest")
            }
        })
    end,
}
