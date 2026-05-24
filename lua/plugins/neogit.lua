-- neogit: magit-like git interface (`<leader>gg`), with diffview integration
-- keywords: git, magit, commit, stage, vcs, interface
return {
    "txemaotero/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        commit_view = {
            invert_open_file = false,
        },
    },
}
