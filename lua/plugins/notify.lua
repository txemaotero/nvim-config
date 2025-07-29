-- Fancy notifications
return {
    'rcarriga/nvim-notify',
    config = function()
        require("notify").setup({
            -- Animation style (see below for details)
            stages = "fade_in_slide_out",

            -- Default timeout for notifications
            timeout = 1000,
        })

        vim.notify = require("notify")
    end
}
