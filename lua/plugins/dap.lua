return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
    },
    config = function()
        local dap = require('dap')
        require('dapui').setup()

        vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text='🟠', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapLogPoint', {text='🟢', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapStopped', {text='➡️ ', texthl='', linehl='', numhl=''})

        dap.adapters.python = {
            type = 'executable';
            command = 'python3';
            args = { '-m', 'debugpy.adapter' };
        }

        dap.configurations.python = {
            {
                -- The first three options are required by nvim-dap
                type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = 'launch';
                name = "Launch file";

                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                program = "${file}"; -- This configuration will launch the current file if used.
            },
        }

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = 'C:\\Users\\josote3651\\Desktop\\programas\\cpptools-extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
            options = {
                detached = false
            }
        }

        dap.configurations.cpp = {
            {
                name = "(Windows) ldpApp Debug",
                type = "cppdbg",
                request = "launch",
                program = "C:\\Users\\josote3651\\Desktop\\repos\\lidar_processing_newArch\\bin\\ldpApp\\win64_vc141\\withGraphics\\notLogPerformance\\Debug\\ldpAppD.exe",
                stopAtEntry = false,
                cwd = "C:\\Users\\josote3651\\Desktop\\repos\\lidar_processing_newArch\\bin\\ldpApp\\win64_vc141\\withGraphics\\notLogPerformance\\Debug",
                -- cwd = '${workspaceFolder}',
                externalConsole = true,
                MIMode = "gdb",
                MIDebuggerPath = "gdb.exe"
            },
        }

    end
}
