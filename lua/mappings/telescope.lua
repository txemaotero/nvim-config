-- <leader>s*: Telescope pickers (the search hub). Includes nested groups
-- for git (<leader>sg*), DAP (<leader>sd*) and LSP (<leader>sl*) pickers.
local wk = require("which-key")

local find_pluggin_files = function()
    require("telescope.builtin").find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
    })
end

local function search_word_under_cursor()
    require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end

local function search_WORD_under_cursor()
    require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
end

local function get_selection()
    -- does not handle rectangular selection
    local s_start = vim.fn.getpos(".")
    local s_end = vim.fn.getpos("v")
    local lines = vim.fn.getregion(s_start, s_end)
    return table.concat(lines, "")
end

local function search_visual_selection()
    require("telescope.builtin").grep_string({ search = get_selection() })
end

wk.add({
    -- visual-mode shortcut so `<leader>s` over a selection greps it
    { "<leader>s", search_visual_selection, desc = "Search selection", mode = "v" },

    { "<leader>/", require("config.telescope.multigrep").live_multigrep, desc = "Find text" },

    { "<leader>s",   group = "Telescope" },
    { "<leader>s/",  "<cmd>Telescope commands_history<cr>",                                     desc = "History" },
    { "<leader>s;",  "<cmd>Telescope commands<cr>",                                             desc = "Commands" },
    { "<leader>sB",  "<cmd>Telescope buffers<cr>",                                              desc = "Open buffers" },
    { "<leader>sH",  "<cmd>Telescope highlights<cr>",                                           desc = "Highlights" },
    { "<leader>sM",  "<cmd>Telescope man_pages<cr>",                                            desc = "Man pages" },
    { "<leader>sP",  find_pluggin_files,                                                        desc = "Find Pluggin files" },
    { "<leader>sS",  "<cmd>Telescope colorscheme<cr>",                                          desc = "Color schemes" },
    { "<leader>sT",  "<cmd>Telescope current_buffer_tags<cr>",                                  desc = "Buffer tags" },
    { "<leader>sa",  "<cmd>Telescope live_grep<cr>",                                            desc = "Find text" },
    { "<leader>sb",  "<cmd>Telescope current_buffer_fuzzy_find<cr>",                            desc = "Current buffer" },
    { "<leader>sc",  "<cmd>Telescope git_commits<cr>",                                          desc = "Commits" },
    { "<leader>sf",  "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>", desc = "Files" },
    { "<leader>sh",  "<cmd>Telescope help_tags<cr>",                                            desc = "Help tags" },
    { "<leader>sk",  "<cmd>Telescope keymaps<cr>",                                              desc = "Keymaps" },
    { "<leader>sm",  "<cmd>Telescope marks<cr>",                                                desc = "Marks" },
    { "<leader>sp",  "<cmd>Telescope tags<cr>",                                                 desc = "Project tags" },
    { "<leader>sq",  "<cmd>Telescope quickfix<cr>",                                             desc = "Quickfix list" },
    { "<leader>sr",  "<cmd>Telescope registers<cr>",                                            desc = "Registers" },
    { "<leader>ss",  function() require("telescope.builtin").resume() end,                     desc = "Resume" },
    { "<leader>st",  "<cmd>Telescope spell_suggest<cr>",                                        desc = "Spell suggestions" },
    { "<leader>sw",  search_word_under_cursor,                                                  desc = "word under cursor" },
    { "<leader>sW",  search_WORD_under_cursor,                                                  desc = "WORD under cursor" },
    { "<leader>sy",  "<cmd>Telescope yank_history<cr>",                                         desc = "Yank hist." },
    { "<leader>sz",  "<cmd>Telescope<cr>",                                                      desc = "Telescope" },

    { "<leader>sd",  group = "DAP" },
    { "<leader>sdC", "<cmd>Telescope dap configurations<cr>",                                   desc = "Configurations" },
    { "<leader>sdb", "<cmd>Telescope dap list_breakpoints<cr>",                                 desc = "Breakpoints" },
    { "<leader>sdc", "<cmd>Telescope dap commands<cr>",                                         desc = "Commands" },
    { "<leader>sdf", "<cmd>Telescope dap frames<cr>",                                           desc = "Frames" },
    { "<leader>sdv", "<cmd>Telescope dap variables<cr>",                                        desc = "Variables" },

    { "<leader>sg",  group = "git" },
    { "<leader>sgC", "<cmd>Telescope git_bcommits<cr>",                                         desc = "Buffer commits" },
    { "<leader>sgS", "<cmd>Telescope git_stash<cr>",                                            desc = "Stash" },
    { "<leader>sgb", "<cmd>Telescope git_branches<cr>",                                         desc = "Branches" },
    { "<leader>sgc", "<cmd>Telescope git_commits<cr>",                                          desc = "Commits" },
    { "<leader>sgs", "<cmd>Telescope git_status<cr>",                                           desc = "Status" },

    { "<leader>sl",  group = "LSP" },
    { "<leader>slD", "<cmd>Telescope diagnostics<cr>",                                          desc = "Proj diagnostics" },
    { "<leader>slS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                        desc = "Proj symbols" },
    { "<leader>sld", "<cmd>Telescope diagnostics bufnr=0<cr>",                                  desc = "Buf diagnostics" },
    { "<leader>slr", "<cmd>Telescope lsp_references<cr>",                                       desc = "References" },
    { "<leader>sls", "<cmd>Telescope lsp_document_symbols<cr>",                                 desc = "Buf symbols" },
})
