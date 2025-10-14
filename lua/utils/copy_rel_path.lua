local M = {}

local function current_relpath()
  local buf = vim.api.nvim_get_current_buf()

  if vim.bo[buf].buftype ~= "" then return nil end

  local abs = vim.api.nvim_buf_get_name(buf)
  if abs == "" then return nil end

  local rel = vim.fn.fnamemodify(abs, ":.")
  return rel ~= "" and rel or vim.fn.fnamemodify(abs, ":t")
end

local function copy(text)
  vim.fn.setreg('"', text)
  pcall(vim.fn.setreg, '+', text)
  pcall(vim.fn.setreg, '*', text)
  vim.notify("Copied: " .. text, vim.log.levels.INFO)
end

function M.copy_relpath()
  local rel = current_relpath()
  if not rel then
    vim.notify("Not path to file in this buffer", vim.log.levels.WARN)
    return
  end
  copy(rel)
end

function M.copy_relpath_with_line()
  local rel = current_relpath()
  if not rel then
    vim.notify("Not path to file in this buffer", vim.log.levels.WARN)
    return
  end
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  copy(("%s:%d"):format(rel, lnum))
end

return M

