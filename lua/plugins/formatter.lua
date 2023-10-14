return {
    "mhartington/formatter.nvim",
    config = function()
        -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        local util = require "formatter.util"
        require("formatter").setup({
            -- Enable or disable logging
            logging = true,
            -- Set the log level
            log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = {
                lua = {
                    require("formatter.filetypes.lua").stylua,
                },
                python = {
                    require("formatter.filetypes.python").balck,
                },
                css = {
                    require("formatter.filetypes.css").prettier,
                },
                javascript = {
                    require("formatter.filetypes.javascript").prettier,
                },
                html = {
                    require("formatter.filetypes.html").prettier,
                },
                c = {
                    function()
                        return {
                            exe = "clang-format",
                            args = {
                                "-assume-filename",
                                util.escape_path(util.get_current_buffer_file_name()),
                                '--style="{BasedOnStyle: Mozilla, IndentWidth: 4, ColumnLimit: 120}"'
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                cpp = {
                    function()
                        return {
                            exe = "clang-format",
                            args = {
                                "-assume-filename",
                                util.escape_path(util.get_current_buffer_file_name()),
                                '--style="{BasedOnStyle: Mozilla, IndentWidth: 4, ColumnLimit: 120}"'
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                cmake = {
                    require("formatter.filetypes.cmake").cmakeformat,
                },
                ["*"] = {
                    require("formatter.filetypes.any").remove_trailing_whitespace,
                },
            },
        })
    end,
}
