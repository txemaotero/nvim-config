-- <leader>n*: neorg navigation, link insertion, workspaces, GTD tasks.
local wk = require("which-key")

wk.add({
    { "<leader>n",   group = "Neorg" },
    { "<leader>nf",  "<cmd>Telescope neorg insert_file_link<cr>",      desc = "File link" },
    { "<leader>nh",  "<cmd>Telescope neorg search_headings<cr>",       desc = "Find headings" },
    { "<leader>nl",  "<cmd>Telescope neorg insert_link<cr>",           desc = "New link" },
    { "<leader>np",  "<cmd>Neorg workspace personal<cr>",              desc = "Personal" },
    { "<leader>ns",  "<cmd>Telescope neorg find_linkable<cr>",         desc = "Find link" },
    { "<leader>nw",  "<cmd>Neorg workspace work<cr>",                  desc = "Work" },

    { "<leader>nt",  group = "Tasks" },
    { "<leader>ntc", "<cmd>Neorg gtd capture<cr>",                     desc = "Capture" },
    { "<leader>nte", "<cmd>Neorg gtd edit<cr>",                        desc = "Edit" },
    { "<leader>nts", "<cmd>Telescope neorg find_project_tasks<cr>",    desc = "Find tasks" },
    { "<leader>ntt", "<cmd>Neorg workspace gtd<cr>",                   desc = "Tasks" },
    { "<leader>ntv", "<cmd>Neorg gtd views<cr>",                       desc = "Views" },
})
