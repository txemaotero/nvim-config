local wk = require("which-key")

vim.keymap.set({ "n", "x" }, "<C-Z>", "<Nop>")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        wk.add({
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
    pattern = "norg",
    callback = function()
        wk.add({
            {"<CR>", "<Plug>(neorg.esupports.hop.hop-link)", desc="Jump"}
            },
            { buffer = true }
        )
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",

    callback = function()
        wk.add({
            {"j", "gj", "" },
            {"k", "gk", "" },
            },
            { buffer = true }
        )
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        wk.add({
            {"<CR>", "<cmd>.cc<cr><cmd>copen<cr>", "View current" },
            {"o", "<cmd>.cc<cr><cmd>cclose<cr>", "Jump current" },
            },
            { buffer = true })
    end,
})

local function go_middle()
    local line = vim.api.nvim_get_current_line()
    local middle_pos = math.floor(string.len(line) / 2)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_win_set_cursor(0, { curr_line, middle_pos })
end

-- Special yank
wk.add(
    {
        { "<C-n>", "<Plug>(YankyCycleForward)",  desc = "Yank Forward" },
        { "<C-p>", "<Plug>(YankyCycleBackward)", desc = "Yank Back" },
        {
            { "P",  "<Plug>(YankyPutBefore)",  desc = "Put before" },
            { "gP", "<Plug>(YankyGPutBefore)", desc = "GPut before" },
            { "gm", go_middle,                 desc = "Go middle line" },
            { "gp", "<Plug>(YankyGPutAfter)",  desc = "GPut after" },
            { "p",  "<Plug>(YankyPutAfter)",   desc = "Put after" },
            { "y",  "<Plug>(YankyYank)",       desc = "Yank" },
            mode = { "n", "x" },
        },
    }
)

-- Copy to clipboard
wk.add(
    {
        { "<leader>p", '"_dP', desc = "Paste from clipboard", mode = "x" },
        { "<leader>D", '"_d',  desc = "Delete to clipboard",  mode = { "n", "v" } },
        { "<leader>y", '"+y',  desc = "Copy to clipboard",    mode = { "n", "v" } },
    }
)

-- Move Lines
wk.add(
    {
        { "<C-j>", ":m '>+1<CR>gv=gv", desc = "Move down", mode = "v" },
        { "<C-k>", ":m '<-2<CR>gv=gv", desc = "Move up",   mode = "v" },
    }
)

-- Root mappings
wk.add(
    {
        { "<C-h>",   "<cmd>NavigatorLeft<cr>",  desc = "Window h" },
        { "<C-j>",   "<cmd>NavigatorDown<cr>",  desc = "Window j" },
        { "<C-k>",   "<cmd>NavigatorUp<cr>",    desc = "Window k" },
        { "<C-l>",   "<cmd>NavigatorRight<cr>", desc = "Window l" },
        { "<CR>",    "o<Esc>",                  desc = "New line" },
        { "<S-Tab>", "<cmd>tabnext<cr>",        desc = "Next tab" },
        { "D",       "d$",                      desc = "Delete until end" },
        { "J",       "mzJ`z",                   desc = "Join lines" },
        { "Y",       "y$",                      desc = "Yank until end" },
        { "gp",      "`[v`]",                   desc = "Select pasted" },
        { "ga",      "<Plug>(EasyAlign)",       desc = "EasyAlign",       mode = { "n", "x" } },
    }
)

-- Emacs like motions in command mode
wk.add(
    {
        {
            mode = { "t" },
            { "<C-A>",         "<Home>",      desc = "Home" },
            { "<C-B>",         "<Left>",      desc = "Left" },
            { "<C-D>",         "<Del>",       desc = "Delete" },
            { "<C-E>",         "<End>",       desc = "End" },
            { "<C-F>",         "<Right>",     desc = "Right" },
            { "<C-N>",         "<Down>",      desc = "Down" },
            { "<C-P>",         "<Up>",        desc = "Up" },
            { "<leader><Esc>", "<C-\\><C-n>", desc = "Esc" },
        },
    }
)

local find_pluggin_files = function ()
    require("telescope.builtin").find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
    }
end

wk.add(
    {
        { "<leader>.",     "<cmd>e $MYVIMRC<cr>",                                                                       desc = "Open config" },
        { "<leader>/",     require("config.telescope.multigrep").live_multigrep,                                        desc = "Find text" },
        { "<leader>;",     "<cmd>Telescope commands<cr>",                                                               desc = "Commands" },
        { "<leader><Tab>", "<cmd>b#<cr>",                                                                               desc = "Alternate buffer" },
        { "<leader>H",     "<C-W>s",                                                                                    desc = "Split below" },
        { "<leader>N",     "<cmd>let @/ = ''<cr>",                                                                      desc = "No highlight" },
        { "<leader>O",     "<cmd>tabe<cr>",                                                                             desc = "Open New Tab" },
        { "<leader>T",     group = "terminal" },
        { "<leader>T;",    "<cmd>FloatermNew --wintype=normal --height=6<cr>",                                          desc = "terminal" },
        { "<leader>Td",    "<cmd>FloatermNew lazydocker<cr>",                                                           desc = "docker" },
        { "<leader>Te",    "<cmd>FloatermNew vifm<cr>",                                                                 desc = "vifm" },
        { "<leader>Tf",    "<cmd>FloatermNew fzf<cr>",                                                                  desc = "fzf" },
        { "<leader>Tg",    "<cmd>FloatermNew lazygit<cr>",                                                              desc = "git" },
        { "<leader>Ti",    "<cmd>FloatermNew ipython<cr>",                                                              desc = "ipython" },
        { "<leader>Tp",    "<cmd>FloatermNew python<cr>",                                                               desc = "python" },
        { "<leader>Tr",    "<cmd>FloatermNew ranger<cr>",                                                               desc = "ranger" },
        { "<leader>Ts",    "<cmd>FloatermNew ncdu<cr>",                                                                 desc = "ncdu" },
        { "<leader>Tt",    "<cmd>FloatermToggle<cr>",                                                                   desc = "toggle" },
        { "<leader>Ty",    "<cmd>FloatermNew ytop<cr>",                                                                 desc = "ytop" },
        { "<leader>V",     "<C-W>v",                                                                                    desc = "Split right" },
        { "<leader>b",     group = "Buffer" },
        { "<leader>bb",    "<cmd>Telescope buffers<cr>",                                                                desc = "Telescope find" },
        { "<leader>bd",    "<cmd>bd<cr>",                                                                               desc = "Delete" },
        { "<leader>bf",    "<cmd>bfirst<cr>",                                                                           desc = "First" },
        { "<leader>bl",    "<cmd>blast<cr>",                                                                            desc = "Last" },
        { "<leader>bn",    "<cmd>bn<cr>",                                                                               desc = "Next" },
        { "<leader>bp",    "<cmd>bp<cr>",                                                                               desc = "Previous" },
        { "<leader>d",     group = "Debug" },
        { "<leader>dL",    function() require("dap").run_last() end,                                                    desc = "Run last" },
        { "<leader>db",    function() require("dap").toggle_breakpoint() end,                                           desc = "Breakpoint" },
        { "<leader>dc",    function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,        desc = "Cond. break" },
        { "<leader>dd",    function() require("dap").continue() end,                                                    desc = "Debug" },
        { "<leader>di",    function() require("dapui").eval() end,                                                      desc = "Info",               mode = { "n", "v" } },
        { "<leader>dj",    function() require("dap").step_over() end,                                                   desc = "Step over" },
        { "<leader>dk",    function() require("dap").step_out() end,                                                    desc = "Step out" },
        { "<leader>dl",    function() require("dap").step_into() end,                                                   desc = "Step into" },
        { "<leader>dm",    function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Log message" },
        { "<leader>dr",    function() require("dap").repl.open() end,                                                   desc = "Repl open" },
        { "<leader>dt",    function() require("dapui").toggle({}) end,                                                  desc = "Toggle UI" },
        { "<leader>e",     "<cmd>edit %:p:h<cr>",                                                                       desc = "Explorer" },
        { "<leader>f",     group = "File" },
        { "<leader>fS",    "<cmd>wall<cr>",                                                                             desc = "Save all" },
        { "<leader>fa",    function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end, desc = "Find All Files" },
        { "<leader>ff",    "<cmd>Telescope find_files<cr>",                                                             desc = "Find File" },
        { "<leader>fr",    "<cmd>Telescope oldfiles<cr>",                                                               desc = "Recent Files" },
        { "<leader>fs",    "<cmd>w<cr>",                                                                                desc = "Save" },
        { "<leader>g",     group = "Git" },
        { "<leader>gB",    "<cmd>Gitsigns toggle_current_line_blame<cr>",                                               desc = "Toggle blame all" },
        { "<leader>gP",    "<cmd>Git push<cr>",                                                                         desc = "push" },
        { "<leader>gb",    "<cmd>Gitsigns blame_line<cr>",                                                              desc = "Blame line" },
        { "<leader>gg",    "<cmd>Neogit<cr>",                                                                           desc = "Git" },
        { "<leader>gm",    desc = "Messenger" },
        { "<leader>gp",    "<cmd>Git pull<cr>",                                                                         desc = "pull" },
        { "<leader>gs",    "<cmd>Git status<cr>",                                                                       desc = "Status" },
        { "<leader>gt",    "<cmd>FloatermNew lazygit<cr>",                                                              desc = "Lazygit" },
        { "<leader>gv",    "<cmd>GV<cr>",                                                                               desc = "View log" },
        { "<leader>i",     group = "Info" },
        { "<leader>iD",    "<cmd>TroubleToggle workspace_diagnostics<cr>",                                              desc = "Project diagnostics" },
        { "<leader>id",    "<cmd>TroubleToggle document_diagnostics<cr>",                                               desc = "File diagnostics" },
        { "<leader>ii",    "<cmd>TroubleToggle <cr>",                                                                   desc = "Trouble" },
        { "<leader>il",    "<cmd>TroubleToggle loclist<cr>",                                                            desc = "Loclist" },
        { "<leader>iq",    "<cmd>TroubleToggle quickfix<cr>",                                                           desc = "Quickfix" },
        { "<leader>ir",    "<cmd>TroubleToggle lsp_references<cr>",                                                     desc = "Symbol references" },
        { "<leader>j",     group = "Jupyter" },
        { "<leader>jJ",    "<Plug>JupyterExecuteAll",                                                                   desc = "Run all cells" },
        { "<leader>jj",    "<Plug>JupyterExecute",                                                                      desc = "Run current cell" },
        { "<leader>l",     group = "LSP" },
        { "<leader>l=",    desc = "Format range" },
        { "<leader>l?",    "<cmd>SymbolsOutline<cr>",                                                                   desc = "List variables" },
        { "<leader>lD",    desc = "Diagnostics" },
        { "<leader>la",    desc = "Action" },
        { "<leader>ld",    group = "Document" },
        { "<leader>ldc",   desc = "Class" },
        { "<leader>ldf",   desc = "Function" },
        { "<leader>lf",    "<cmd>Format<cr>",                                                                           desc = "Format file" },
        { "<leader>lr",    desc = "Rename" },
        { "<leader>n",     group = "Neorg" },
        { "<leader>nf",    "<cmd>Telescope neorg insert_file_link<cr>",                                                 desc = "File link" },
        { "<leader>nh",    "<cmd>Telescope neorg search_headings<cr>",                                                  desc = "Find headdings" },
        { "<leader>nl",    "<cmd>Telescope neorg insert_link<cr>",                                                      desc = "New link" },
        { "<leader>np",    "<cmd>Neorg workspace personal<cr>",                                                         desc = "Personal" },
        { "<leader>ns",    "<cmd>Telescope neorg find_linkable<cr>",                                                    desc = "Find link" },
        { "<leader>nt",    group = "Tasks" },
        { "<leader>ntc",   "<cmd>Neorg gtd capture<cr>",                                                                desc = "Capture" },
        { "<leader>nte",   "<cmd>Neorg gtd edit<cr>",                                                                   desc = "Edit" },
        { "<leader>nts",   "<cmd>Telescope neorg find_project_tasks<cr>",                                               desc = "Find tasks" },
        { "<leader>ntt",   "<cmd>Neorg workspace gtd<cr>",                                                              desc = "Tasks" },
        { "<leader>ntv",   "<cmd>Neorg gtd views<cr>",                                                                  desc = "Views" },
        { "<leader>nw",    "<cmd>Neorg workspace work<cr>",                                                             desc = "Work" },
        { "<leader>o",     group = "Overseer" },
        { "<leader>ol",    "<cmd>OverseerRestartLast<cr>",                                                              desc = "Toggle" },
        { "<leader>oo",    "<cmd>OverseerRun<cr>",                                                                      desc = "Run task" },
        { "<leader>os",    "<cmd>OverseerOpenLastOutput<cr>",                                                           desc = "Toggle" },
        { "<leader>ot",    "<cmd>OverseerToggle<cr>",                                                                   desc = "Toggle" },
        { "<leader>s",     group = "Telescope" },
        { "<leader>s/",    "<cmd>Telescope commands_history<cr>",                                                       desc = "History" },
        { "<leader>s;",    "<cmd>Telescope commands<cr>",                                                               desc = "Commands" },
        { "<leader>sB",    "<cmd>Telescope buffers<cr>",                                                                desc = "Open buffers" },
        { "<leader>sH",    "<cmd>Telescope highlights<cr>",                                                             desc = "Highlights" },
        { "<leader>sM",    "<cmd>Telescope man_pages<cr>",                                                              desc = "Man pages" },
        { "<leader>sP",    find_pluggin_files,                                                                          desc = "Find Pluggin files" },
        { "<leader>sS",    "<cmd>Telescope colorscheme<cr>",                                                            desc = "Color schemes" },
        { "<leader>sT",    "<cmd>Telescope cuffent_buffer_tags<cr>",                                                    desc = "Buffer tags" },
        { "<leader>sa",    "<cmd>Telescope live_grep<cr>",                                                              desc = "Find text" },
        { "<leader>sb",    "<cmd>Telescope current_buffer_fuzzy_find<cr>",                                              desc = "Current buffer" },
        { "<leader>sc",    "<cmd>Telescope git_commits<cr>",                                                            desc = "Commits" },
        { "<leader>sd",    group = "DAP" },
        { "<leader>sdC",   "<cmd>Telescope dap configurations<cr>",                                                     desc = "Configurations" },
        { "<leader>sdb",   "<cmd>Telescope dap list_breakpoints<cr>",                                                   desc = "Breakpoints" },
        { "<leader>sdc",   "<cmd>Telescope dap commands<cr>",                                                           desc = "Commands" },
        { "<leader>sdf",   "<cmd>Telescope dap frames<cr>",                                                             desc = "Frames" },
        { "<leader>sdv",   "<cmd>Telescope dap variables<cr>",                                                          desc = "Variables" },
        { "<leader>sf",    "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>",                   desc = "Files" },
        { "<leader>sg",    group = "git" },
        { "<leader>sgC",   "<cmd>Telescope git_bcommits<cr>",                                                           desc = "Buffer commits" },
        { "<leader>sgS",   "<cmd>Telescope git_stash<cr>",                                                              desc = "Stash" },
        { "<leader>sgb",   "<cmd>Telescope git_branches<cr>",                                                           desc = "Commits" },
        { "<leader>sgc",   "<cmd>Telescope git_commits<cr>",                                                            desc = "Commits" },
        { "<leader>sgs",   "<cmd>Telescope git_status<cr>",                                                             desc = "Status" },
        { "<leader>sh",    "<cmd>Telescope help_tags<cr>",                                                              desc = "Help tags" },
        { "<leader>sk",    "<cmd>Telescope keymaps<cr>",                                                                desc = "Keymaps" },
        { "<leader>sl",    group = "LSP" },
        { "<leader>slD",   "<cmd>Telescope lsp_workspace_diagnostics<cr>",                                              desc = "Proj diagnostics" },
        { "<leader>slS",   "<cmd>Telescope lsp_workspace_symbols<cr>",                                                  desc = "Proj symbols" },
        { "<leader>sla",   "<cmd>Telescope lsp_code_actions<cr>",                                                       desc = "Actions" },
        { "<leader>sld",   "<cmd>Telescope lsp_document_diagnostics<cr>",                                               desc = "Buf diagnostics" },
        { "<leader>slr",   "<cmd>Telescope lsp_references<cr>",                                                         desc = "References" },
        { "<leader>sls",   "<cmd>Telescope lsp_document_symbols<cr>",                                                   desc = "Buf symbols" },
        { "<leader>sm",    "<cmd>Telescope marks<cr>",                                                                  desc = "Marks" },
        { "<leader>sp",    "<cmd>Telescope tags<cr>",                                                                   desc = "Project tags" },
        { "<leader>sq",    "<cmd>Telescope quickfix<cr>",                                                               desc = "Qhickfix list" },
        { "<leader>sr",    "<cmd>Telescope registers<cr>",                                                              desc = "Registers" },
        { "<leader>ss",    "<cmd>Telescope ultisnips<cr>",                                                              desc = "Snippets" },
        { "<leader>st",    "<cmd>Telescope spell_suggest<cr>",                                                          desc = "Spell suggestions" },
        { "<leader>sw",    group = "Wiki" },
        { "<leader>swg",   "<cmd>Telescope vimwiki live_grep<cr>",                                                      desc = "Grep" },
        { "<leader>swl",   "<cmd>Telescope vimwiki link<cr>",                                                           desc = "Links" },
        { "<leader>sww",   "<cmd>Telescope vimwiki<cr>",                                                                desc = "Pages" },
        { "<leader>sy",    "<cmd>Telescope yank_history<cr>",                                                           desc = "Yank hist." },
        { "<leader>sz",    "<cmd>Telescope<cr>",                                                                        desc = "Telescope" },
        { "<leader>t",     group = "test" },
        { "<leader>tD",    function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end,         desc = "Debug File" },
        { "<leader>tS",    function() require("neotest").run.stop() end,                                                desc = "Stop" },
        { "<leader>tT",    function() require("neotest").run.run(vim.fn.expand("%")) end,                               desc = "File" },
        { "<leader>ta",    function() require("neotest").run.attach() end,                                              desc = "Attach" },
        { "<leader>td",    function() require("neotest").run.run({ strategy = "dap" }) end,                             desc = "Debug closest" },
        { "<leader>tl",    function() require("neotest").run.run_last() end,                                            desc = "Last" },
        { "<leader>to",    function() require("neotest").output.open() end,                                             desc = "Output" },
        { "<leader>ts",    function() require("neotest").summary.toggle() end,                                          desc = "Summary" },
        { "<leader>tt",    function() require("neotest").run.run() end,                                                 desc = "Closest" },
        { "<leader>v",     desc = "Inc. selection" },
        { "<leader>w",     group = "window" },
        { "<leader>w=",    "<C-w>=",                                                                                    desc = "Restore" },
        { "<leader>wF",    "<C-w>_",                                                                                    desc = "Focus hsplit" },
        { "<leader>wQ",    "<C-w>o",                                                                                    desc = "Keep current" },
        { "<leader>wS",    "<C-w>s<C-w>l",                                                                              desc = "HSplit & focus" },
        { "<leader>wV",    "<C-w>v<C-w>j",                                                                              desc = "VSplit & focus" },
        { "<leader>wf",    "<C-w>|",                                                                                    desc = "Focus vsplit" },
        { "<leader>wh",    "<C-w>h",                                                                                    desc = "Move h" },
        { "<leader>wj",    "<C-w>j",                                                                                    desc = "Move j" },
        { "<leader>wk",    "<C-w>k",                                                                                    desc = "Move k" },
        { "<leader>wl",    "<C-w>l",                                                                                    desc = "Move l" },
        { "<leader>wm",    "<cmd>lua require('maximize').toggle()<cr>",                                                 desc = "Maximize curr" },
        { "<leader>wo",    "<C-w>o",                                                                                    desc = "Keep current" },
        { "<leader>wq",    "<C-w>q",                                                                                    desc = "Quit current" },
        { "<leader>ws",    "<C-w>s",                                                                                    desc = "HSplit hor" },
        { "<leader>wt",    "<C-w>T",                                                                                    desc = "Move to tab" },
        { "<leader>wv",    "<C-w>v",                                                                                    desc = "VSplit vert" },
        { "<leader>ww",    "<C-w>w",                                                                                    desc = "Move to last" },
    }
)
