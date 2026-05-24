-- neotest: test runner framework with pytest and Google Test adapters; `<leader>t*` mappings
-- keywords: tests, testing, pytest, gtest, googletest, run, debug
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "nvim-neotest/nvim-nio",
        "alfaix/neotest-gtest",
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
