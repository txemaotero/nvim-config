-- Aggregates every mapping module. Each module is responsible for one
-- domain (telescope, lsp, dap, ...) and registers its own keymaps via
-- which-key when required.

require("mappings.core")
require("mappings.yanky")
require("mappings.window")
require("mappings.buffer")
require("mappings.file")
require("mappings.copy")
require("mappings.telescope")
require("mappings.lsp")
require("mappings.trouble")
require("mappings.git")
require("mappings.dap")
require("mappings.test")
require("mappings.neorg")
require("mappings.overseer")
require("mappings.terminal")
