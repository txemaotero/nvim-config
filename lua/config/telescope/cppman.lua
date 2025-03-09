local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config".values
local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local Job = require "plenary.job"


local M = {}

local function open_cppman_page(page_name)
    -- Set buffer options
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, {split = "above", win = 0})

    vim.bo.ro = false
    vim.bo.ma = true

    local win_width = vim.api.nvim_win_get_width(0) - 2

    vim.api.nvim_buf_set_lines(buf, 0, -1, true, {}) -- Clear the buffer
    local cmd = string.format([[0r! cppman --force-columns %d '%s']], win_width, page_name)
    vim.cmd(cmd)
    vim.cmd("0")

    -- Final buffer settings
    vim.bo.ro = true
    vim.bo.ma = false
    vim.bo.mod = false

    vim.bo.keywordprg = "cppman"
    vim.bo.buftype = "nofile"
    vim.bo.filetype = "cppman"
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, false, true), 'n', true)
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
        attach_mappings = function(_, map)
            map({"i", "n"}, "<CR>", function(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                    actions.close(prompt_bufnr)
                    open_cppman_page(selection.value)
                end
            end)
            return true
        end,
    }):find()
end
M.telescope_cppman()
return M
