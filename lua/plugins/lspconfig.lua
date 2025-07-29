return {
    "neovim/nvim-lspconfig",
    config = function()
        local opts = { noremap = true, silent = true }
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
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

        -- Setup lspconfig in cmp.
        require "lsp_signature".setup({
            toggle_key = '<C-e>',
        })

        -- Setup lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.offsetEncoding = { "utf-16" }

        vim.lsp.config("*", {})
        vim.lsp.config["clangd"] = {
            cmd = {"/usr/bin/clangd-19", "--clang-tidy"}
        }
        vim.lsp.config["cmake"] = {
            root_markers = {"CMakePresets.json", "build"},
        }

        vim.lsp.config["lua_ls"] = {
            cmd = { 'lua-language-server' },
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
        vim.lsp.enable({"clangd", "cmake", "texlab", "pyright", "lua_ls"})
    end
}
