local wk = require("which-key")

local function toggle_quickfix()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win["quickfix"] == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end

local function reload_plugin(plugin_name)
  for name, _ in pairs(package.loaded) do
    if name:match("^" .. plugin_name) then
      package.loaded[name] = nil
    end
  end
  require(plugin_name).setup()
end

wk.add({
    { "<leader>R", function() reload_plugin("neogit") end, desc = "Reload neogit" }
})

vim.keymap.set({ "n", "x" }, "<C-Z>", "<Nop>")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        wk.add({
            {"<CR>", "<C-]>", desc = "Follow link", buffer=0 },
            {"<BS>" ,  "<C-T>", desc = "Go back", buffer=0 },
            {"o"        ,  "/'\\l\\{2,\\}'<CR>", desc = "Next option", buffer=0 },
            {"O"        ,  "?'\\l\\{2,\\}'<CR>", desc = "Prev. option", buffer=0 },
            {"s"        ,  "/|.\\{-}|<CR>", desc = "Next subject", buffer=0 },
            {"S"        ,  "?|.\\{-}|<CR>", desc = "Prev. subject", buffer=0 },
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    callback = function()
        wk.add({
            { "<leader>ks", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file" }
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "norg",
    callback = function()
        wk.add({
            {"<CR>", "<Plug>(neorg.esupports.hop.hop-link)", desc="Jump", buffer=0}
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",

    callback = function()
        wk.add({
            {"j", "gj", buffer=0},
            {"k", "gk", buffer=0},
        })
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
            { "gm", go_middle,                 desc = "Go middle line" },
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
        { "<C-h>",   "<C-w>h",            desc = "Window h" },
        { "<C-j>",   "<C-w>j",            desc = "Window j" },
        { "<C-k>",   "<C-w>k",            desc = "Window k" },
        { "<C-l>",   "<C-w>l",            desc = "Window l" },
        { "<CR>",    "o<Esc>",            desc = "New line" },
        { "<S-Tab>", "<cmd>tabnext<cr>",  desc = "Next tab" },
        { "D",       "d$",                desc = "Delete until end" },
        { "J",       "mzJ`z",             desc = "Join lines" },
        { "Y",       "y$",                desc = "Yank until end" },
        { "gp",      "`[v`]",             desc = "Select pasted" },
        { "ga",      "<Plug>(EasyAlign)", desc = "EasyAlign",          mode = { "n", "x" } },
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
            { "<Esc><Esc>", "<C-\\><C-n>", desc = "Esc" },
        },
    }
)

local find_pluggin_files = function ()
    require("telescope.builtin").find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
    }
end

local function search_word_under_cursor()
    local word = vim.fn.expand("<cword>")
    require("telescope.builtin").grep_string({ search = word })
end

local function search_WORD_under_cursor()
    local word = vim.fn.expand("<cWORD>")
    require("telescope.builtin").grep_string({ search = word })
end

local function get_selection()
   -- does not handle rectangular selection
   local s_start = vim.fn.getpos "."
   local s_end = vim.fn.getpos "v"
   local lines = vim.fn.getregion(s_start,s_end)
   return table.concat(lines, "")
end

local function search_visual_selection()
    require("telescope.builtin").grep_string({ search = get_selection() })
end

wk.add(
    {
        { "<leader>s", search_visual_selection, desc = "Search selection", mode = "v" },
    }
)

wk.add(
    {
        { "-",             "<cmd>edit %:p:h<cr>",                                                                desc = "Explorer" },
        { "<leader>.",     "<cmd>e $MYVIMRC<cr>",                                                                desc = "Open config" },
        { "<leader>/",     require("config.telescope.multigrep").live_multigrep,                                 desc = "Find text" },
        { "<leader>;",     "<cmd>Telescope commands<cr>",                                                        desc = "Commands" },
        { "<leader><Tab>", "<cmd>b#<cr>",                                                                        desc = "Alternate buffer" },
        { "<leader>N",     "<cmd>let @/ = ''<cr>",                                                               desc = "No highlight" },
        { "<leader>O",     "<cmd>tabe<cr>",                                                                      desc = "Open New Tab" },
        { "<leader>T",     group = "terminal" },
        { "<leader>Tt",    "<cmd>FloatermNew --wintype=normal --height=10<cr>",                                  desc = "terminal" },
        { "<leader>TT",    "<cmd>FloatermToggle<cr>",                                                            desc = "toggle" },
        { "<leader>c",     group = "Copy" },
        { "<leader>cp",  require("utils/copy_rel_path").copy_relpath,                                                         desc = "Copy relative path" },
        { "<leader>cP",  require("utils/copy_rel_path").copy_relpath_with_line,                                                         desc = "Copy relative path with line" },
        { "<leader>b",     group = "Buffer" },
        { "<leader>bb",    "<cmd>Telescope buffers<cr>",                                                         desc = "Telescope find" },
        { "<leader>bd",    "<cmd>bd<cr>",                                                                        desc = "Delete" },
        { "<leader>bD",    "<cmd>bd!<cr>",                                                                       desc = "Delete" },
        { "<leader>bn",    "<cmd>bn<cr>",                                                                        desc = "Next" },
        { "<leader>bp",    "<cmd>bp<cr>",                                                                        desc = "Previous" },
        { "<leader>d",     group = "Debug" },
        { "<leader>dL",    function() require("dap").run_last() end,                                             desc = "Run last" },
        { "<leader>db",    function() require("dap").toggle_breakpoint() end,                                    desc = "Breakpoint" },
        { "<leader>dc",    function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Cond. break" },
        { "<leader>di",    function() require("dapui").eval() end,                                               desc = "Info",                  mode = { "n",                             "v" } },
        { "<leader>dm",    function() require("dap").set_breakpoint(nil,                                         nil,                            vim.fn.input("Log point message: ")) end, desc = "Log message" },
        { "<leader>dt",    function() require("dapui").toggle({}) end,                                           desc = "Toggle UI" },
        { "<leader>ds",    function() require("dap").terminate() end,                                            desc = "Toggle UI" },
        { "<leader>dd",    function() require("dap").continue() end,                                             desc = "Debug" },
        { "<leader>dl",    function() require"osv".launch({port = 8086}) end,                                    desc = "Run lua dap server" },
        { "<F5>",          function() require("dap").down() end,                                                 desc = "Debug" },
        { "<F4>",          function() require("dap").up() end,                                                   desc = "Debug" },
        { "<F7>",          function() require("dap").continue() end,                                             desc = "Debug" },
        { "<F8>",          function() require("dap").step_over() end,                                            desc = "Step over" },
        { "<F9>",          function() require("dap").step_out() end,                                             desc = "Step out" },
        { "<F10>",         function() require("dap").step_into() end,                                            desc = "Step into" },
        { "<leader>e",     "<cmd>edit %:p:h<cr>",                                                                desc = "Explorer" },
        { "<leader>f",     group = "File" },
        { "<leader>fS",    "<cmd>wall<cr>",                                                                      desc = "Save all" },
        { "<leader>fa",    function() require("telescope.builtin").find_files({ hidden = true,                   no_ignore = true }) end,        desc = "Find All Files" },
        { "<leader>ff",    "<cmd>Telescope find_files<cr>",                                                      desc = "Find File" },
        { "<leader>fr",    "<cmd>Telescope oldfiles<cr>",                                                        desc = "Recent Files" },
        { "<leader>fs",    "<cmd>w<cr>",                                                                         desc = "Save" },
        { "<leader>g",     group = "Git" },
        { "<leader>gB",    "<cmd>Gitsigns toggle_current_line_blame<cr>",                                        desc = "Toggle blame all" },
        { "<leader>gb",    "<cmd>Gitsigns blame_line<cr>",                                                       desc = "Blame line" },
        { "<leader>gg",    "<cmd>Neogit<cr>",                                                                    desc = "Git" },
        { "<leader>gv",    "<cmd>GV<cr>",                                                                        desc = "View log" },
        { "<leader>i",     group = "Info" },
        { "<leader>iD",    "<cmd>Trouble diagnostics toggle<cr>",                                                desc = "Project diagnostics" },
        { "<leader>id",    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                                   desc = "Buffer diagnostics" },
        { "<leader>ii",    "<cmd>Trouble<cr>",                                                                   desc = "Trouble" },
        { "<leader>il",    "<cmd>Trouble loclist toggle<cr>",                                                    desc = "Loclist" },
        { "<leader>iq",    "<cmd>Trouble flist toggle<cr>",                                                      desc = "Quickfix" },
        { "<leader>ir",    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",                         desc = "Symbol references" },
        { "<leader>l",     group = "LSP" },
        { "<leader>l=",    desc = "Format range" },
        { "<leader>lD",    desc = "Diagnostics" },
        { "<leader>la",    desc = "Action" },
        { "<leader>ld",    group = "Document" },
        { "<leader>ldc",   desc = "Class" },
        { "<leader>ldf",   desc = "Function" },
        { "<leader>lf",    "<cmd>Format<cr>",                                                                    desc = "Format file" },
        { "<leader>lr",    desc = "Rename" },
        { "<leader>n",     group = "Neorg" },
        { "<leader>nf",    "<cmd>Telescope neorg insert_file_link<cr>",                                          desc = "File link" },
        { "<leader>nh",    "<cmd>Telescope neorg search_headings<cr>",                                           desc = "Find headdings" },
        { "<leader>nl",    "<cmd>Telescope neorg insert_link<cr>",                                               desc = "New link" },
        { "<leader>np",    "<cmd>Neorg workspace personal<cr>",                                                  desc = "Personal" },
        { "<leader>ns",    "<cmd>Telescope neorg find_linkable<cr>",                                             desc = "Find link" },
        { "<leader>nt",    group = "Tasks" },
        { "<leader>ntc",   "<cmd>Neorg gtd capture<cr>",                                                         desc = "Capture" },
        { "<leader>nte",   "<cmd>Neorg gtd edit<cr>",                                                            desc = "Edit" },
        { "<leader>nts",   "<cmd>Telescope neorg find_project_tasks<cr>",                                        desc = "Find tasks" },
        { "<leader>ntt",   "<cmd>Neorg workspace gtd<cr>",                                                       desc = "Tasks" },
        { "<leader>ntv",   "<cmd>Neorg gtd views<cr>",                                                           desc = "Views" },
        { "<leader>nw",    "<cmd>Neorg workspace work<cr>",                                                      desc = "Work" },
        { "<leader>o",     group = "Overseer" },
        { "<leader>ol",    "<cmd>OverseerRestartLast<cr>",                                                       desc = "Toggle" },
        { "<leader>oo",    "<cmd>OverseerRun<cr>",                                                               desc = "Run task" },
        { "<leader>os",    "<cmd>OverseerOpenLastOutput<cr>",                                                    desc = "Toggle" },
        { "<leader>ot",    "<cmd>OverseerToggle<cr>",                                                            desc = "Toggle" },
        { "<leader>q",    toggle_quickfix,                                                            desc = "Toggle Quickfix" },
        { "<leader>s",     group = "Telescope" },
        { "<leader>s/",    "<cmd>Telescope commands_history<cr>",                                                desc = "History" },
        { "<leader>s;",    "<cmd>Telescope commands<cr>",                                                        desc = "Commands" },
        { "<leader>sB",    "<cmd>Telescope buffers<cr>",                                                         desc = "Open buffers" },
        { "<leader>sH",    "<cmd>Telescope highlights<cr>",                                                      desc = "Highlights" },
        { "<leader>sM",    "<cmd>Telescope man_pages<cr>",                                                       desc = "Man pages" },
        { "<leader>sP",    find_pluggin_files,                                                                   desc = "Find Pluggin files" },
        { "<leader>sS",    "<cmd>Telescope colorscheme<cr>",                                                     desc = "Color schemes" },
        { "<leader>sT",    "<cmd>Telescope cuffent_buffer_tags<cr>",                                             desc = "Buffer tags" },
        { "<leader>sa",    "<cmd>Telescope live_grep<cr>",                                                       desc = "Find text" },
        { "<leader>sb",    "<cmd>Telescope current_buffer_fuzzy_find<cr>",                                       desc = "Current buffer" },
        { "<leader>sc",    "<cmd>Telescope git_commits<cr>",                                                     desc = "Commits" },
        { "<leader>sd",    group = "DAP" },
        { "<leader>sdC",   "<cmd>Telescope dap configurations<cr>",                                              desc = "Configurations" },
        { "<leader>sdb",   "<cmd>Telescope dap list_breakpoints<cr>",                                            desc = "Breakpoints" },
        { "<leader>sdc",   "<cmd>Telescope dap commands<cr>",                                                    desc = "Commands" },
        { "<leader>sdf",   "<cmd>Telescope dap frames<cr>",                                                      desc = "Frames" },
        { "<leader>sdv",   "<cmd>Telescope dap variables<cr>",                                                   desc = "Variables" },
        { "<leader>sf",    "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>",            desc = "Files" },
        { "<leader>sg",    group = "git" },
        { "<leader>sgC",   "<cmd>Telescope git_bcommits<cr>",                                                    desc = "Buffer commits" },
        { "<leader>sgS",   "<cmd>Telescope git_stash<cr>",                                                       desc = "Stash" },
        { "<leader>sgb",   "<cmd>Telescope git_branches<cr>",                                                    desc = "Commits" },
        { "<leader>sgc",   "<cmd>Telescope git_commits<cr>",                                                     desc = "Commits" },
        { "<leader>sgs",   "<cmd>Telescope git_status<cr>",                                                      desc = "Status" },
        { "<leader>sh",    "<cmd>Telescope help_tags<cr>",                                                       desc = "Help tags" },
        { "<leader>sk",    "<cmd>Telescope keymaps<cr>",                                                         desc = "Keymaps" },
        { "<leader>sl",    group = "LSP" },
        { "<leader>slD",   "<cmd>Telescope lsp_workspace_diagnostics<cr>",                                       desc = "Proj diagnostics" },
        { "<leader>slS",   "<cmd>Telescope lsp_workspace_symbols<cr>",                                           desc = "Proj symbols" },
        { "<leader>sla",   "<cmd>Telescope lsp_code_actions<cr>",                                                desc = "Actions" },
        { "<leader>sld",   "<cmd>Telescope lsp_document_diagnostics<cr>",                                        desc = "Buf diagnostics" },
        { "<leader>slr",   "<cmd>Telescope lsp_references<cr>",                                                  desc = "References" },
        { "<leader>sls",   "<cmd>Telescope lsp_document_symbols<cr>",                                            desc = "Buf symbols" },
        { "<leader>sm",    "<cmd>Telescope marks<cr>",                                                           desc = "Marks" },
        { "<leader>sp",    "<cmd>Telescope tags<cr>",                                                            desc = "Project tags" },
        { "<leader>sq",    "<cmd>Telescope quickfix<cr>",                                                        desc = "Qhickfix list" },
        { "<leader>sr",    "<cmd>Telescope registers<cr>",                                                       desc = "Registers" },
        { "<leader>ss",    "<cmd>Telescope ultisnips<cr>",                                                       desc = "Snippets" },
        { "<leader>st",    "<cmd>Telescope spell_suggest<cr>",                                                   desc = "Spell suggestions" },
        { "<leader>sw",    search_word_under_cursor,                                                             desc = "word under cursor" },
        { "<leader>sW",    search_WORD_under_cursor,                                                             desc = "WORD under cursor" },
        { "<leader>sy",    "<cmd>Telescope yank_history<cr>",                                                    desc = "Yank hist." },
        { "<leader>sz",    "<cmd>Telescope<cr>",                                                                 desc = "Telescope" },
        { "<leader>t",     group = "test" },
        { "<leader>tD",    function() require("neotest").run.run({ vim.fn.expand("%"),                           strategy = "dap" }) end,        desc = "Debug File" },
        { "<leader>tS",    function() require("neotest").run.stop() end,                                         desc = "Stop" },
        { "<leader>tT",    function() require("neotest").run.run(vim.fn.expand("%")) end,                        desc = "File" },
        { "<leader>ta",    function() require("neotest").run.attach() end,                                       desc = "Attach" },
        { "<leader>td",    function() require("neotest").run.run({ strategy = "dap" }) end,                      desc = "Debug closest" },
        { "<leader>tl",    function() require("neotest").run.run_last() end,                                     desc = "Last" },
        { "<leader>to",    function() require("neotest").output.open() end,                                      desc = "Output" },
        { "<leader>ts",    function() require("neotest").summary.toggle() end,                                   desc = "Summary" },
        { "<leader>tt",    function() require("neotest").run.run() end,                                          desc = "Closest" },
        { "<leader>w",     group = "window" },
        { "<leader>w=",    "<C-w>=",                                                                             desc = "Restore" },
        { "<leader>wF",    "<C-w>_",                                                                             desc = "Focus hsplit" },
        { "<leader>wf",    "<C-w>|",                                                                             desc = "Focus vsplit" },
        { "<leader>wS",    "<C-w>s<C-w>j",                                                                       desc = "HSplit & focus" },
        { "<leader>wV",    "<C-w>v<C-w>l",                                                                       desc = "VSplit & focus" },
        { "<leader>wh",    "<C-w>h",                                                                             desc = "Move h" },
        { "<leader>wj",    "<C-w>j",                                                                             desc = "Move j" },
        { "<leader>wk",    "<C-w>k",                                                                             desc = "Move k" },
        { "<leader>wl",    "<C-w>l",                                                                             desc = "Move l" },
        { "<leader>wo",    "<C-w>o",                                                                             desc = "Keep current" },
        { "<leader>wq",    "<C-w>q",                                                                             desc = "Quit current" },
        { "<leader>ws",    "<C-w>s",                                                                             desc = "HSplit hor" },
        { "<leader>wt",    "<C-w>T",                                                                             desc = "Move to tab" },
        { "<leader>wv",    "<C-w>v",                                                                             desc = "VSplit vert" },
        { "<leader>ww",    "<C-w>w",                                                                             desc = "Move to last" },
        { "<leader>W", function() vim.o.wrap = not vim.o.wrap end,                                                                             desc = "Togle wrap" },
    }
)
