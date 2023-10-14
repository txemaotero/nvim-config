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
    end
}
