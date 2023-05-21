local keymap = vim.keymap
-- Telescope
local telescope = require("telescope.builtin")
keymap.set("n", "<C-p>", telescope.find_files, {})
keymap.set("n", "<C-t>", function() vim.cmd("Telescope") end, {noremap = true})
