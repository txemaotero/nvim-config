return {
    dir = "~/repos/telescope-cppman.nvim",
    config = function ()
        vim.keymap.set("n", "<leader>C", require("cppman").telescope_cppman)
    end
}
