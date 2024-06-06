return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'mfussenegger/nvim-dap-python',
    },
    config = function()
        local dap = require('dap')
        require('dapui').setup()

        require("dap-python").setup("python3")

        vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text='🟠', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapLogPoint', {text='🟢', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapStopped', {text='➡️ ', texthl='', linehl='', numhl=''})

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = '/home/txema/programs/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description =  'enable pretty printing',
                    ignoreFailures = false
                },
                {
                    text = "python import sys;sys.path.insert(0, '/usr/share/gcc/python');from libstdcxx.v6.printers import register_libstdcxx_printers;register_libstdcxx_printers(None)",
                    description =  'Test',
                    ignoreFailures = false
                },
            },
        }

        dap.adapters.lldb = {
            type = 'executable',
            command = '/usr/bin/lldb-dap-18', -- adjust as needed, must be absolute path
            name = 'lldb'
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.expand('%:p:r'), 'file')
                end,
                cwd = '${workspaceFolder}',
                options = {
                    detached = false,
                }
            },
        }

        dap.configurations.cpp = {
            {
                name = 'Launch lldb',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.expand('%:p:r'), 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},

                -- 💀
                -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                --
                --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                --
                -- Otherwise you might get the following error:
                --
                --    Error on launch: Failed to attach to the target process
                --
                -- But you should be aware of the implications:
                -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                -- runInTerminal = false,
            },
        }
    end
}
