return {
    "neovim/nvim-lspconfig",
    config = function()
        -- Buffer-local keymaps on LSP attach
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local bufopts = { noremap = true, silent = true, buffer = args.bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', '<space>lwa', vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>lwr', vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set('n', '<space>lwl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', function() vim.cmd [[Telescope lsp_references]] end, bufopts)
                vim.keymap.set('n', '<space>l=', function() vim.lsp.formatexpr() end, bufopts)
            end,
        })

        require("lsp_signature").setup({
            toggle_key = '<C-e>',
        })

        -- nvim-cmp completion capabilities applied to every server
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        vim.lsp.config("*", { capabilities = capabilities })

        vim.lsp.config("clangd", {
            cmd = { "/usr/bin/clangd-19", "--clang-tidy" },
            capabilities = { offsetEncoding = { "utf-16" } },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        })

        vim.lsp.enable({ "clangd", "cmake", "texlab", "pyright", "lua_ls", "rust_analyzer" })
    end,
}
