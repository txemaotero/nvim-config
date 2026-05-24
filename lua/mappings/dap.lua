-- <leader>d* and F4-F10: DAP control (breakpoints, stepping, UI, eval).
local wk = require("which-key")

wk.add({
    { "<leader>d",  group = "Debug" },
    { "<leader>dL", function() require("dap").run_last() end,                                                  desc = "Run last" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                                         desc = "Breakpoint" },
    { "<leader>dc", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,      desc = "Cond. break" },
    { "<leader>dd", function() require("dap").continue() end,                                                  desc = "Debug" },
    { "<leader>di", function() require("dapui").eval() end,                                                    desc = "Info",      mode = { "n", "v" } },
    { "<leader>dl", function() require("osv").launch({ port = 8086 }) end,                                     desc = "Run lua dap server" },
    { "<leader>dm", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Log message" },
    { "<leader>ds", function() require("dap").terminate() end,                                                 desc = "Terminate" },
    { "<leader>dt", function() require("dapui").toggle({}) end,                                                desc = "Toggle UI" },

    { "<F4>",  function() require("dap").up() end,         desc = "DAP up" },
    { "<F5>",  function() require("dap").down() end,       desc = "DAP down" },
    { "<F7>",  function() require("dap").continue() end,   desc = "Continue" },
    { "<F8>",  function() require("dap").step_over() end,  desc = "Step over" },
    { "<F9>",  function() require("dap").step_out() end,   desc = "Step out" },
    { "<F10>", function() require("dap").step_into() end,  desc = "Step into" },
})
