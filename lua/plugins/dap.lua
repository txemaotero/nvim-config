return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'mfussenegger/nvim-dap-python',
    },
    config = function()
        local dap = require('dap')
        require('dapui').setup()

        vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapBreakpointCondition', {text='🟠', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapLogPoint', {text='🟢', texthl='', linehl='', numhl=''})
        vim.fn.sign_define('DapStopped', {text='➡️ ', texthl='', linehl='', numhl=''})

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = '/home/txema/programs/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
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
            },
        }
    end
}
