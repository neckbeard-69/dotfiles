vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
keymap.set({ "i" }, "jk", "<ESC>", { desc = "Go to normal mode" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>th", "<cmd>Telescope colorscheme<CR>") -- show available color schemes
-- panes navigation
keymap.set("n", "<A-h>", ":wincmd h<CR>")
keymap.set("n", "<M-j>", function()
    if vim.opt.diff:get() then
        vim.cmd([[normal! ]c]])
    else
        vim.cmd([[m .+1<CR>==]])
    end
end)

keymap.set("n", "<M-k>", function()
    if vim.opt.diff:get() then
        vim.cmd([[normal! [c]])
    else
        vim.cmd([[m .-2<CR>==]])
    end
end)
keymap.set("n", "<A-l>", ":wincmd l<CR>")

keymap.set("i", "<A-h>", "<Esc>:wincmd h<CR>")
keymap.set("i", "<A-k>", "<Esc>:wincmd k<CR>")
keymap.set("i", "<A-j>", "<Esc>:wincmd j<CR>")
keymap.set("i", "<A-l>", "<Esc>:wincmd l<CR>")
-- Custom motions
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz") -- center the cursor automatically
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz") -- center the cursor automatically
-- Custom commands for speed
keymap.set("n", "<C-s>", ":w<CR>")           -- save the file
keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

-- Fix original commands
keymap.set({ "n", "i", "v" }, "<C-z>", "")
keymap.set({ "v" }, "p", "P")
-- language specific keymaps
-- GO:
keymap.set("n", "<leader>ee", "oif error != nil {\n\treturn error\n}<ESC>")
