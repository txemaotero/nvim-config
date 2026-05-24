-- <leader>t*: neotest commands (run, debug, output, summary, attach).
local wk = require("which-key")

wk.add({
    { "<leader>t",  group = "test" },
    { "<leader>tD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, desc = "Debug File" },
    { "<leader>tS", function() require("neotest").run.stop() end,                                        desc = "Stop" },
    { "<leader>tT", function() require("neotest").run.run(vim.fn.expand("%")) end,                       desc = "File" },
    { "<leader>ta", function() require("neotest").run.attach() end,                                      desc = "Attach" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,                     desc = "Debug closest" },
    { "<leader>tl", function() require("neotest").run.run_last() end,                                    desc = "Last" },
    { "<leader>to", function() require("neotest").output.open() end,                                     desc = "Output" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,                                  desc = "Summary" },
    { "<leader>tt", function() require("neotest").run.run() end,                                         desc = "Closest" },
})
