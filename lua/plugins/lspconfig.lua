return {
    "neovim/nvim-lspconfig",
    config = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<space>ld', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>lq', vim.diagnostic.setloclist, opts)

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
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
            vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = false, timeout = 2000 } end, bufopts)
            vim.keymap.set('n', '<space>l=', function() vim.lsp.formatexpr() end, bufopts)
        end


        -- Setup lspconfig in cmp.
        require "lsp_signature".setup({
            toggle_key = '<C-e>',
        })

        -- Setup lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.offsetEncoding = { "utf-16" }

        local nvim_lsp = require('lspconfig')

        local cmake_on_attach = function(bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', '<space>lmsb', "<cmd>CMakeSelect<cr>", bufopts)
            local wk = require("which-key")
            wk.register({
                    ['<leader>m'] = {
                        name = '+CMake',
                        s = {
                            name = '+Select',
                            b = { "<cmd>CMakeSelectBuildTarget<cr>", "Build Target" },
                            t = { "<cmd>CMakeSelectBuildType<cr>", "Build Type" },
                            l = { "<cmd>CMakeSelectLaunchTarget<cr>", "Launch Target" },
                            p = { "<cmd>CMakeSelectConfigurePreset<cr>", "Configure Preset" },
                        },
                        b = { "<cmd>CMakeBuild<cr>", "Build" },
                        c = { "<cmd>CMakeClean<cr>", "Clean" },
                        r = { "<cmd>CMakeRun<cr>", "Run" },
                        S = { "<cmd>CMakeStop<cr>", "Stop" },
                        i = { "<cmd>CMakeInstall<cr>", "Install" },
                        d = { "<cmd>CMakeDebug<cr>", "Debug" },
                    }
                },
                { buffer = vim.api.nvim_get_current_buf() })
        end
        -- use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        nvim_lsp.clangd.setup {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                cmake_on_attach(bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', '<space>ls', "<cmd>ClangdSwitchSourceHeader<cr>", bufopts)
                vim.keymap.set('n', '<space>D', "<cmd>Dox<cr>", bufopts)
                vim.keymap.set({ 'n', 'v' }, '<space>li', "<cmd>TSCppDefineClassFunc<cr>", bufopts)
            end,
            capabilities = capabilities
        }

        nvim_lsp.cmake.setup {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                cmake_on_attach(bufnr)
            end,
        }

        nvim_lsp.pyright.setup {
            on_attach = on_attach,
            single_file_support = true,
        }

        nvim_lsp.rust_analyzer.setup {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                ["rust-analyzer"] = {}
            }
        }

        nvim_lsp.lua_ls.setup {
            on_attach = on_attach,
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
    end
}
