local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "<leader>a", "<C-a>") --the original doesn't work with tmux
keymap.set("n", "<leader>x", "<C-x>") --the original doesn't work with tmux
keymap.set("i", "<A-h>", "<Esc>:wincmd h<CR>")
keymap.set("i", "<A-k>", "<Esc>:wincmd k<CR>")
keymap.set("i", "<A-j>", "<Esc>:wincmd j<CR>")
keymap.set("i", "<A-l>", "<Esc>:wincmd l<CR>")
-- Custom motions
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
keymap.set({ "n", "x", "o" }, "<C-j>", "G")
keymap.set({ "n", "x", "o" }, "<C-k>", "gg")
keymap.set({ "n", "x", "o" }, "<C-l>", "$")
keymap.set({ "n", "x", "o" }, "<C-h>", "0")
keymap.set({ "n", "x", "o" }, "m", "%")
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

keymap.set("n", "<C-s>", ":w<CR>")
keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

keymap.set({ "n", "i", "v" }, "<C-z>", "")
keymap.set({ "v" }, "p", "P")
keymap.set("n", "<leader>th", function()
    require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

vim.keymap.set({ "n", "t" }, "<leader>tt", function()
    require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end)
