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
        require("neotest-gtest").setup({})
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                }),
                require("neotest-gtest")
            }
        })
    end,
}
