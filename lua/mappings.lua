local wk = require("which-key")

vim.keymap.set({ "n", "x" }, "<C-Z>", "<Nop>")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        wk.register({
            ["<CR>"] = { "<C-]>", "Follow link" },
            ["<BS>"] = { "<C-T>", "Go back" },
            o        = { "/'\\l\\{2,\\}'<CR>", "Next option" },
            O        = { "?'\\l\\{2,\\}'<CR>", "Prev. option" },
            s        = { "/|.\\{-}|<CR>", "Next subject" },
            S        = { "?|.\\{-}|<CR>", "Prev. subject" },
        },
            { buffer = vim.api.nvim_get_current_buf() }
        )
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        wk.register({
            ["<CR>"] = { "<cmd>.cc<cr><cmd>copen<cr>", "View current" },
            o = { "<cmd>.cc<cr><cmd>cclose<cr>", "Jump current" },
        },
            { buffer = vim.api.nvim_get_current_buf() })
    end,
})

local function go_middle()
    local line = vim.api.nvim_get_current_line()
    local middle_pos = math.floor(string.len(line) / 2)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_win_set_cursor(0, { curr_line, middle_pos })
end

-- Special yank
wk.register(
    {
        y = { "<Plug>(YankyYank)", "Yank" },
        p = { "<Plug>(YankyPutAfter)", "Yank" },
        P = { "<Plug>(YankyPutBefore)", "Yank" },
        gm = { go_middle, "Go middle line" },
        gp = { "<Plug>(YankyGPutAfter)", "Yank" },
        gP = { "<Plug>(YankyGPutBefore)", "Yank" },
        ["<C-n>"] = { "<Plug>(YankyCycleForward)", "Yank", mode = { "n" } },
        ["<C-p>"] = { "<Plug>(YankyCycleBackward)", "Yank", mode = { "n" } }
    },
    {
        mode = { "n", "x" }
    }
)

-- Harpoon
local ui = require("harpoon.ui")

wk.register(
    {
        ["<C-e>"] = { ui.toggle_quick_menu, "Harpoon" },
        ["+"] = { function() ui.nav_file(1) end, "Harpoon Nav 1" },
        ["-"] = { function() ui.nav_file(2) end, "Harpoon Nav 2" },
        ["ñ"] = { function() ui.nav_file(3) end, "Harpoon Nav 3" },
        ["<C-t>"] = { function() ui.nav_file(4) end, "Harpoon Nav 4" },
    }
)


-- Copy to clipboard
wk.register(
    {
        ["<leader>p"] = { [["_dP]], "Paste from clipboard", mode = "x" },
        ["<leader>y"] = { [["+y]], "Copy to clipboard", mode = { "n", "v" } },
        ["<leader>D"] = { [["_d]], "Delete to clipboard", mode = { "n", "v" } },
    }
)

-- Move Lines
wk.register(
    {
        ["<C-j>"] = { ":m '>+1<CR>gv=gv", "Move down" },
        ["<C-k>"] = { ":m '<-2<CR>gv=gv", "Move up" },
    },
    {
        mode = "v"
    }
)

-- Root mappings
wk.register(
    {
        ["<CR>"]  = { "o<Esc>", "New line" },
        ["<F5>"]  = { function() require("dap").continue() end, "Start Debug" },
        ["<C-j>"] = { "<C-w>j", "Window j" },
        ["<C-h>"] = { "<C-w>h", "Window h" },
        ["<C-l>"] = { "<C-w>l", "Window l" },
        ["<C-k>"] = { "<C-w>k", "Window k" },
        ga        = { "<Plug>(EasyAlign)", "EasyAlign", mode = { "n", "x" } },
        gp        = { "`[v`]", "Select pasted"},
        D         = { "d$", "Delete until end" },
        Y         = { "y$", "Yank until end" },
        J         = { "mzJ`z", "Join lines" },
    }
)

-- Emacs like motions in command mode
wk.register(
    {
        ["<C-A>"] = { "<Home>", "Home" },
        ["<C-B>"] = { "<Left>", "Left" },
        ["<C-D>"] = { "<Del>", "Delete" },
        ["<C-E>"] = { "<End>", "End" },
        ["<C-F>"] = { "<Right>", "Right" },
        ["<C-N>"] = { "<Down>", "Down" },
        ["<C-P>"] = { "<Up>", "Up" },
        ["<leader><Esc>"] = { "<C-\\><C-n>", "Esc" },
    },
    { mode = "t" }
)

wk.register(
    {
        ["<leader>"] = {
            ["/"] = { "<cmd>Telescope live_grep<cr>", "Find text" },
            ["<Tab>"] = { "<cmd>b#<cr>", "Alternate buffer" },
            ["."] = { "<cmd>e $MYVIMRC<cr>", "Open config" },
            [";"] = { "<cmd>Telescope commands<cr>", "Commands" },
            e = { "<cmd>edit %:p:h<cr>", "Explorer" },
            H = { "<C-W>s", "Split below" },
            M = { require("harpoon.mark").add_file, "Add file to harpoon" },
            N = { "<cmd>let @/ = ''<cr>", "No highlight" },
            v = "Inc. selection",
            V = { "<C-W>v", "Split right" },
            b = {
                name = "+Buffer",
                d = { "<cmd>bd<cr>", "Delete" },
                f = { "<cmd>bfirst<cr>", "First" },
                l = { "<cmd>blast<cr>", "Last" },
                n = { "<cmd>bn<cr>", "Next" },
                p = { "<cmd>bp<cr>", "Previous" },
                b = { "<cmd>Telescope buffers<cr>", "Telescope find" },
            },
            d = {
                name = "+Debug",
                i = { function() require("dapui").eval() end, "Info", mode = { "n", "v" } },
                b = { function() require("dap").toggle_breakpoint() end, "Breakpoint" },
                c = { function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
                    "Cond. break", },
                d = { function() require("dap").continue() end, "Debug", },
                j = { function() require("dap").step_over() end, "Step over", },
                k = { function() require("dap").step_out() end, "Step out", },
                l = { function() require("dap").step_into() end, "Step into", },
                L = { function() require("dap").run_last() end, "Run last", },
                m = { function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
                    "Log message", },
                r = { function() require("dap").repl.open() end, "Repl open", },
                t = { function() require("dapui").toggle({}) end, "Toggle UI", },
            },
            f = {
                name = "+File",
                f = { "<cmd>Telescope find_files<cr>", "Find File" },
                a = { function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
                    "Find All Files" },
                r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
                s = { "<cmd>w<cr>", "Save" },
                S = { "<cmd>wall<cr>", "Save all" },
            },
            g = {
                name = "+Git",
                B = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle blame all" },
                b = { "<cmd>Gitsigns blame_line<cr>", "Blame line" },
                s = { "<cmd>Git status<cr>", "Status" },
                t = { "<cmd>FloatermNew lazygit<cr>", "Lazygit" },
                m = "Messenger",
                v = { "<cmd>GV<cr>", "View log" },
                w = { function() require('telescope').extensions.git_worktree.git_worktrees() end, "Worktree" },
                W = { function() require('telescope').extensions.git_worktree.create_git_worktree() end, "New worktree" }
            },
            i = {
                name = "+Info",
                D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Project diagnostics" },
                d = { "<cmd>TroubleToggle document_diagnostics<cr>", "File diagnostics" },
                i = { "<cmd>TroubleToggle <cr>", "Trouble" },
                l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
                q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
                r = { "<cmd>TroubleToggle lsp_references<cr>", "Symbol references" },
            },
            j = {
                name = "+Jupyter",
                j = { "<Plug>JupyterExecute", "Run current cell" },
                J = { "<Plug>JupyterExecuteAll", "Run all cells" },
            },
            l = {
                name = "+LSP",
                ["?"] = { "<cmd>SymbolsOutline<cr>", "List variables" },
                ["="] = "Format range",
                f = "Format file",
                r = "Rename",
                a = "Action",
                D = "Diagnostics",
                d = {
                    name = "+Document",
                    f = "Function",
                    c = "Class",
                }
            },
            n = {
                name = "+Neorg",
                t = {
                    name = "+Tasks",
                    c = { "<cmd>Neorg gtd capture<cr>", "Capture" },
                    e = { "<cmd>Neorg gtd edit<cr>", "Edit" },
                    v = { "<cmd>Neorg gtd views<cr>", "Views" },
                    s = { "<cmd>Telescope neorg find_project_tasks<cr>", "Find tasks" },
                    t = { "<cmd>Neorg workspace gtd<cr>", "Tasks" },
                },
                w = { "<cmd>Neorg workspace work<cr>", "Work" },
                p = { "<cmd>Neorg workspace personal<cr>", "Personal" },
                l = { "<cmd>Telescope neorg insert_link<cr>", "New link" },
                s = { "<cmd>Telescope neorg find_linkable<cr>", "Find link" },
                f = { "<cmd>Telescope neorg insert_file_link<cr>", "File link" },
                h = { "<cmd>Telescope neorg search_headings<cr>", "Find headdings" },
            },
            s = {
                name = "+Telescope",
                ["/"] = { "<cmd>Telescope commands_history<cr>", "History" },
                [";"] = { "<cmd>Telescope commands<cr>", "Commands" },
                a = { "<cmd>Telescope live_grep<cr>", "Find text" },
                b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current buffer" },
                B = { "<cmd>Telescope buffers<cr>", "Open buffers" },
                c = { "<cmd>Telescope git_commits<cr>", "Commits" },
                d = {
                    name = "+DAP",
                    c = { "<cmd>Telescope dap commands<cr>", "Commands" },
                    C = { "<cmd>Telescope dap configurations<cr>", "Configurations" },
                    b = { "<cmd>Telescope dap list_breakpoints<cr>", "Breakpoints" },
                    v = { "<cmd>Telescope dap variables<cr>", "Variables" },
                    f = { "<cmd>Telescope dap frames<cr>", "Frames" },
                },
                f = { "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>", "Files" },
                g = {
                    name = "+git",
                    c = { "<cmd>Telescope git_commits<cr>", "Commits" },
                    C = { "<cmd>Telescope git_bcommits<cr>", "Buffer commits" },
                    b = { "<cmd>Telescope git_branches<cr>", "Commits" },
                    s = { "<cmd>Telescope git_status<cr>", "Status" },
                    S = { "<cmd>Telescope git_stash<cr>", "Stash" },
                },
                h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
                H = { "<cmd>Telescope highlights<cr>", "Highlights" },
                l = {
                    name = "+LSP",
                    a = { "<cmd>Telescope lsp_code_actions<cr>", "Actions" },
                    r = { "<cmd>Telescope lsp_references<cr>", "References" },
                    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Buf symbols" },
                    S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Proj symbols" },
                    d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Buf diagnostics" },
                    D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Proj diagnostics" },
                },
                k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
                m = { "<cmd>Telescope marks<cr>", "Marks" },
                M = { "<cmd>Telescope man_pages<cr>", "Man pages" },
                p = { "<cmd>Telescope tags<cr>", "Project tags" },
                q = { "<cmd>Telescope quickfix<cr>", "Qhickfix list" },
                r = { "<cmd>Telescope registers<cr>", "Registers" },
                s = { "<cmd>Telescope ultisnips<cr>", "Snippets" },
                S = { "<cmd>Telescope colorscheme<cr>", "Color schemes" },
                t = { "<cmd>Telescope spell_suggest<cr>", "Spell suggestions" },
                T = { "<cmd>Telescope cuffent_buffer_tags<cr>", "Buffer tags" },
                w = {
                    name = "+Wiki",
                    w = { "<cmd>Telescope vimwiki<cr>", "Pages" },
                    g = { "<cmd>Telescope vimwiki live_grep<cr>", "Grep" },
                    l = { "<cmd>Telescope vimwiki link<cr>", "Links" },
                },
                y = { "<cmd>Telescope yank_history<cr>", "Yank hist." },
                z = { "<cmd>Telescope<cr>", "Telescope" },
            },
            o = {
                name = "+Overseer",
                o = { "<cmd>OverseerRun<cr>", "Run task" },
                t = { "<cmd>OverseerToggle<cr>", "Toggle" },
                s = { "<cmd>OverseerOpenLastOutput<cr>", "Toggle" },
                l = { "<cmd>OverseerRestartLast<cr>", "Toggle" },
            },
            t = {
                name = "+test",
                t = { function() require("neotest").run.run() end, "Closest", },
                T = { function() require("neotest").run.run(vim.fn.expand("%")) end, "File", },
                l = { function() require("neotest").run.run_last() end, "Last", },
                a = { function() require("neotest").run.attach() end, "Attach", },
                s = { function() require("neotest").summary.toggle() end, "Summary", },
                S = { function() require("neotest").run.stop() end, "Stop", },
                o = { function() require("neotest").output.open() end, "Output", },
                d = { function() require("neotest").run.run({ strategy = "dap" }) end, "Debug closest", },
                D = { function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, "Debug File", },
            },
            T = {
                name = "+terminal",
                [";"] = { "<cmd>FloatermNew --wintype=normal --height=6<cr>", "terminal" },
                f = { "<cmd>FloatermNew fzf<cr>", "fzf" },
                g = { "<cmd>FloatermNew lazygit<cr>", "git" },
                d = { "<cmd>FloatermNew lazydocker<cr>", "docker" },
                p = { "<cmd>FloatermNew python<cr>", "python" },
                i = { "<cmd>FloatermNew ipython<cr>", "ipython" },
                r = { "<cmd>FloatermNew ranger<cr>", "ranger" },
                e = { "<cmd>FloatermNew vifm<cr>", "vifm" },
                t = { "<cmd>FloatermToggle<cr>", "toggle" },
                y = { "<cmd>FloatermNew ytop<cr>", "ytop" },
                s = { "<cmd>FloatermNew ncdu<cr>", "ncdu" },
            },
            w = {
                name = "+window",
                s = { "<C-w>s", "HSplit hor" },
                S = { "<C-w>s<C-w>l", "HSplit & focus" },
                v = { "<C-w>v", "VSplit vert" },
                V = { "<C-w>v<C-w>j", "VSplit & focus" },
                q = { "<C-w>q", "Quit current" },
                Q = { "<C-w>o", "Keep current" },
                o = { "<C-w>o", "Keep current" },
                w = { "<C-w>w", "Move to last" },
                j = { "<C-w>j", "Move j" },
                h = { "<C-w>h", "Move h" },
                k = { "<C-w>k", "Move k" },
                l = { "<C-w>l", "Move l" },
                t = { "<C-w>T", "Move to tab" },
                f = { "<C-w>|", "Focus vsplit" },
                F = { "<C-w>_", "Focus hsplit" },
                ["="] = { "<C-w>=", "Restore" },
                m = { "<cmd>lua require('maximize').toggle()<cr>", "Maximize curr" },
            },
            h = {
                {
                    name = "+hop",
                    h = { "<cmd>HopWord<cr>", "Word" },
                    w = { "<cmd>HopWord<cr>", "Word" },
                    W = { "<cmd>HopWordMW<cr>", "Word MW" },
                    a = { "<cmd>HopAnywhere<cr>", "Anywhere" },
                    A = { "<cmd>HopAnywhereMW<cr>", "Anywhere MW" },
                    l = { "<cmd>HopLine<cr>", "Line" },
                    L = { "<cmd>HopLineMW<cr>", "Line MW" },
                    c = { "<cmd>HopChar1<cr>", "1 char" },
                    C = { "<cmd>HopChar1MW<cr>", "1 char MW" },
                    t = { "<cmd>HopChar2<cr>", "2 chars" },
                    T = { "<cmd>HopChar2MW<cr>", "2 chars MW" },
                },
                mode = { "n", "v" }
            },
        }
    }
)
