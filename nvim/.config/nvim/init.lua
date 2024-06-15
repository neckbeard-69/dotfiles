require("mohammed.core")
require("mohammed.lazy")
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

-- to resolve a conflict
local keymap = vim.keymap
keymap.set({ "n", "v" }, "<C-j>", "G", { desc = "Go to the end of the file" })
keymap.set("n", "y<C-j>", "yG", { desc = "Copy to the end of the file" })
keymap.set("n", "d<C-j>", "dG", { desc = "Delete to the end of the file" })

keymap.set({ "n", "v" }, "<C-k>", "gg", { desc = "Go to the top of the file" })
keymap.set("n", "y<C-k>", "ygg", { desc = "Copy to the top of the file" })
keymap.set("n", "d<C-k>", "dgg", { desc = "Delete to the top of the file" })

keymap.set({ "n", "v" }, "<C-l>", "$", { desc = "Go to the end of the current line" })
keymap.set("n", "y<C-l>", "y$", { desc = "Copy to the end of the current line" })
keymap.set("n", "d<C-l>", "d$", { desc = "Delete to the end of the current line" })

keymap.set({ "n", "v" }, "<C-h>", "0", { desc = "Go to the start of the current line" })
keymap.set("n", "y<C-h>", "y0", { desc = "Copy to the start of the current line" })
keymap.set("n", "d<C-h>", "d0", { desc = "Delete to the start of the current line" })
