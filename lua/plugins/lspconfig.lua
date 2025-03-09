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
                        S = { "<cmd>CMakeStop<cr>", "Stop" },
                        b = { "<cmd>CMakeBuild<cr>", "Build" },
                        c = { "<cmd>CMakeClean<cr>", "Clean" },
                        d = { "<cmd>CMakeDebug<cr>", "Debug" },
                        g = { "<cmd>CMakeGenerate<cr>", "Generate" },
                        i = { "<cmd>CMakeInstall<cr>", "Install" },
                        o = { "<cmd>CMakeOpen<cr>", "Open" },
                        r = { "<cmd>CMakeRun<cr>", "Run" },
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
            capabilities = capabilities,
            cmd = {"/usr/bin/clangd-18", "--clang-tidy"}
        }

        nvim_lsp.cmake.setup {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                cmake_on_attach(bufnr)
            end,
            root_dir = nvim_lsp.util.root_pattern("CMakePresets.json", "build")
        }

        nvim_lsp.texlab.setup {
            on_attach = on_attach,
            single_file_support = true,
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
