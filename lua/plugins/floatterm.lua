----------- Float terminal -----------
return {
    'voldikss/vim-floaterm',
    init = function()
        -- globals commands
        vim.g.floaterm_keymap_toggle = '<F1>'
        vim.g.floaterm_keymap_next   = '<F2>'
        vim.g.floaterm_keymap_prev   = '<F3>'
        vim.g.floaterm_keymap_new    = '<F4>'
        -- global settings
        vim.g.floaterm_gitcommit='floaterm'
        vim.g.floaterm_autoinsert=1
        vim.g.floaterm_width=0.8
        vim.g.floaterm_height=0.8
        vim.g.floaterm_wintitle=0
        vim.g.floaterm_autoclose=1
        if (vim.fn.has('win32') == 1) then
            vim.g.floaterm_shell = 'C:\\Users\\josote3651\\AppData\\Local\\Microsoft\\WindowsApps\\Microsoft.PowerShell_8wekyb3d8bbwe\\pwsh.exe'
        end
    end
}
