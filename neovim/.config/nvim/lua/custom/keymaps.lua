local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>")
-- Custom motions
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
keymap.set({ "n", "x", "o" }, "<C-j>", "G")
keymap.set({ "n", "x", "o" }, "<C-k>", "gg")
keymap.set({ "n", "x", "o" }, "<C-l>", "$")
keymap.set({ "n", "x", "o" }, "<C-h>", "0")
keymap.set({ "n", "x", "o" }, "m", "%", { remap = true })
keymap.set("n", "<C-s>", ":w<CR>")
keymap.set({ "n", "i", "v" }, "<C-z>", "")
keymap.set("v", "p", "P")
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
keymap.set("n", "<leader>y", "<Cmd>silent %yank<CR>")
