local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Custom motions
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
keymap.set({ "n", "x", "o" }, "<C-j>", "G")
keymap.set({ "n", "x", "o" }, "<C-k>", "gg")
keymap.set({ "n", "x", "o" }, "<C-l>", "$")
keymap.set({ "n", "x", "o" }, "<C-h>", "0")
keymap.set({ "n", "x", "o" }, "m", "%", { noremap = true })
keymap.set("n", "<C-s>", ":w<CR>")
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
keymap.set({ "n", "i", "v" }, "<C-z>", "")
keymap.set("v", "p", "P")
keymap.set("n", "<leader>th", function()
	require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

vim.keymap.set({ "n", "t" }, "<leader>tt", ":belowright sp | term<CR>i") -- opens a terminal in a new pane
