local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config".values
local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local Job = require "plenary.job"


local M = {}

local function buffer_exists(bufnr)
    return bufnr and vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr)
end

local cppman_bufnr = nil

local function get_cppman_bufnr()
    if not buffer_exists(cppman_bufnr) then
        cppman_bufnr = nil
    end
    if not cppman_bufnr then
        cppman_bufnr = vim.api.nvim_create_buf(false, true)

        vim.keymap.set("n", "q", ":q!<cr>", { silent = true, buffer = cppman_bufnr })
        vim.keymap.set("n", "<CR>", M.open_page_under_cursor, { silent = true, buffer = cppman_bufnr })
        vim.keymap.set("n", "<C-O>", M.go_previous_page, { silent = true, buffer = cppman_bufnr })
    end
    return cppman_bufnr
end

local function get_win_with_buf(bufnr)
    if bufnr == nil then
        return nil
    end
    local open_wins = vim.api.nvim_list_wins()
    for _, w in ipairs(open_wins) do
        local bufnr_in_win = vim.api.nvim_win_get_buf(w)
        if bufnr_in_win == bufnr then
            return w
        end
    end
    return nil
end

local function open_and_focus_win(bufnr)
    local win = get_win_with_buf(bufnr)
    if not win then
        vim.api.nvim_open_win(bufnr, true, {split = "above", win = 0, style = "minimal"})
    else
        -- focus
        vim.api.nvim_set_current_win(win)
    end
end

local function go_normal_mode()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, false, true), 'n', true)
end

local function prepare_buf_to_write()
    vim.bo.ro = false
    vim.bo.ma = true
    vim.api.nvim_buf_set_lines(0, 0, -1, true, {})
end

local function write_cppman_to_buffer(page_name)
    local win_width = vim.api.nvim_win_get_width(0) - 2
    local cmd = string.format([[0r! cppman --force-columns %d '%s']], win_width, page_name)
    vim.cmd(cmd)
    go_normal_mode()
end

local function make_buf_readonly()
    vim.bo.ro = true
    vim.bo.ma = false
    vim.bo.mod = false
end

local function set_buf_type()
    vim.bo.keywordprg = "cppman"
    vim.bo.buftype = "nofile"
    vim.bo.filetype = "cppman"
end

local function set_cursor_position(cursor)
    cursor = cursor or {1, 0}
    vim.api.nvim_win_set_cursor(0, cursor)
end

local function load_cppman_page(page_info)
    prepare_buf_to_write()
    write_cppman_to_buffer(page_info.name)
    make_buf_readonly()
    set_buf_type()
    set_cursor_position(page_info.cursor)
end

local current_page = nil
local stack = {}

local function open_cppman_page(page_info)
    local buf = get_cppman_bufnr()
    open_and_focus_win(buf)
    load_cppman_page(page_info)
    current_page = page_info.name
end

M.open_page_under_cursor = function ()
    if vim.api.nvim_get_current_buf() ~= get_cppman_bufnr() then
        stack = {}
        current_page = nil
    end
    if current_page ~= nil then
        table.insert(stack, {name = current_page, cursor = vim.api.nvim_win_get_cursor(0)})
    end
    open_cppman_page({name = vim.fn.expand('<cword>')})
end

M.go_previous_page = function()
    if #stack ~= 0 then
        open_cppman_page(table.remove(stack))
    end
end

local available_cppmans = function()
    local cppman_dir = vim.fn.expand("$HOME/.cache/cppman/man3/")
    local files = vim.fn.globpath(cppman_dir, "*.3.gz", false, true)
    local items = {}
    for _, file in ipairs(files) do
        local name = file:match("([^/]+)%.3%.gz$")
        if name then
            table.insert(items, name)
        end
    end

    return items
end

M.telescope_cppman = function(opts)
    opts = opts or {}
    local finder = finders.new_table {
        results = available_cppmans(),
        entry_maker = opts.entry_maker or function(entry)
                return {
                    value = entry,
                    display = entry,
                    ordinal = entry,
                }
            end,
    }

    pickers.new(opts, {
        debounce = 100,
        prompt_title = "cppman",
        finder = finder,
        previewer = previewers.new_buffer_previewer {
            define_preview = function(self, entry, status)
                if not entry then return end

                local columns = vim.api.nvim_win_get_width(status.preview_win) - 2 -- Get the preview width

                Job:new({
                    command = "cppman",
                    args = { entry.value, "--force-columns", tostring(columns) },
                    on_exit = function(j, _)
                        local result = j:result()
                        if #result == 0 then
                            result = { "No documentation found for " .. entry.value }
                        end
                        vim.schedule(function()
                            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, result)
                            vim.bo.keywordprg = "help"
                            vim.bo.buftype = "nofile"
                            vim.bo.filetype = "help"
                        end)
                    end,
                }):start()
            end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function ()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    open_cppman_page({name = selection.value})
                end
            end)
            return true
        end,
    }):find()
end
M.telescope_cppman()
return M
